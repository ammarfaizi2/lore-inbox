Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUELWEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUELWEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUELWEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:04:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:65187 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262079AbUELWEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:04:15 -0400
Date: Thu, 13 May 2004 02:03:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Assembler warnings on Alpha
Message-ID: <20040513020345.A24739@jurassic.park.msu.ru>
References: <yw1x1xlpv0pj.fsf@kth.se> <xlthdulpdcl.fsf@shookay.newview.com> <yw1xwu3htjp9.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xwu3htjp9.fsf@kth.se>; from mru@kth.se on Wed, May 12, 2004 at 11:32:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 11:32:50PM +0200, Måns Rullgård wrote:
> Sounds promising.  I guess I'll just give it a try.  Now, does anyone
> know what causes those warnings?

For some weird reasons, the new GAS doesn't like "s" (SMALL_DATA)
attribute for the .got section (see asm-alpha/module.h).
These warnings are harmless. I hope the GAS will eventually be
fixed though...

Ivan.
