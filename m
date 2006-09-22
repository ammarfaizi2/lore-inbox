Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWIVHxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWIVHxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWIVHxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:53:53 -0400
Received: from opersys.com ([64.40.108.71]:24071 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750919AbWIVHxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:53:52 -0400
Message-ID: <45139B6B.3000002@opersys.com>
Date: Fri, 22 Sep 2006 04:14:35 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
 management)
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu>
In-Reply-To: <20060922070714.GB4167@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> are you arguing that i'm trying to force breakpoint-based probing on 
> you? I dont. In fact i explicitly mentioned that i'd accept and support 
> a 5-byte NOP in the body of the marker, in the following mails:

Actually that won't work if the kernel runs directly from rom/flash
simply because it's not possible to do any form of binary editing
on the image, as is possible in the more common desktop or workstation
case where the kernel runs from ram.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
