Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGSEPo>; Fri, 19 Jul 2002 00:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318439AbSGSEPo>; Fri, 19 Jul 2002 00:15:44 -0400
Received: from code.and.org ([63.113.167.33]:36303 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S315529AbSGSEPn>;
	Fri, 19 Jul 2002 00:15:43 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more thoughts on a new jail() system call
References: <Pine.LNX.4.44.0207182007090.3525-100000@hawkeye.luckynet.adm>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 19 Jul 2002 00:18:38 -0400
In-Reply-To: <Pine.LNX.4.44.0207182007090.3525-100000@hawkeye.luckynet.adm>
Message-ID: <m33cugnye9.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> On 19 Jul 2002, David Wagner wrote:
> > >sys_ioctl) J - disallowed, but perhaps if devices recognize jails and
> > >filter commands based on that... 
> 
> I think it's quite hard for any type of network application to work well 
> without TIOCINQ.

 The more general spelling is FIONREAD, and I generally find that only
crap network applications need to use it. Good ones just try and read
a largish amount of data into a buffer.

 I'd agree that more than a couple of apps would break without it, but
that isn't what you said.

-- 
James Antill -- <james@and.org>
Firewall n.
 1. A bad security program used to make other bad security programs less
baddly in need of security.
