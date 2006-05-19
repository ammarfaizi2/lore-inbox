Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWESMeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWESMeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 08:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWESMeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 08:34:24 -0400
Received: from ns.suse.de ([195.135.220.2]:32999 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932298AbWESMeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 08:34:23 -0400
From: Andi Kleen <ak@suse.de>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH] kprobes: bad manipulation of 2 byte opcode on x86_64
Date: Fri, 19 May 2006 13:33:11 +0200
User-Agent: KMail/1.8
Cc: Satoshi Oshima <soshima@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       sugita <sugita@sdl.hitachi.co.jp>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org
References: <OFAED3DE10.BAEAFDF2-ON41257173.002E89ED-41257173.002E9AB6@uk.ibm.com>
In-Reply-To: <OFAED3DE10.BAEAFDF2-ON41257173.002E89ED-41257173.002E9AB6@uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605191333.11930.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 May 2006 10:29, Richard J Moore wrote:
> Is there any possibility of a inducing a page fault when checking the
> second byte?

AFAIK instr is in the out of line instruction copy. Kernel would need
to be pretty broken already if that page faulted.

-Andi
