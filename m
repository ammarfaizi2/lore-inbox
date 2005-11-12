Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVKLEnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKLEnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKLEnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:43:04 -0500
Received: from everest.sosdg.org ([66.93.203.161]:41353 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S1751264AbVKLEnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:43:03 -0500
Date: Fri, 11 Nov 2005 23:42:58 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Josh Boyer <jdub@us.ibm.com>, ak@suse.de, akpm@osdl.org
Subject: Re: [patch] mark text section read-only
Message-ID: <20051112044258.GA30298@everest.sosdg.org>
Reply-To: coywolf@sosdg.org
References: <56cTZ-2PF-5@gated-at.bofh.it> <56cTZ-2PF-3@gated-at.bofh.it> <56fRE-7wr-21@gated-at.bofh.it> <56gaT-7Un-17@gated-at.bofh.it> <57DHW-jb-21@gated-at.bofh.it> <57DHW-jb-19@gated-at.bofh.it> <57Mia-4BG-5@gated-at.bofh.it> <57MrY-50s-39@gated-at.bofh.it> <E1Eahvz-0001gP-Uc@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1Eahvz-0001gP-Uc@be1.lrz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 12:03:51AM +0100, Bodo Eggert wrote:
> Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
> 
> > +++ 2.6.14-mm2-cy/init/main.c        2005-11-12 02:50:45.000000000 +0800
> ...
> > +void mark_text_ro(void)
> ...
> > +     printk ("Write protecting the kernel text data: %luk\n",
> > +                     (unsigned long)(_etext - _text) >> 10);
> 
> This message should have a priority level, shouldn't it?

It doesn't matter. It will fall back into the default level.

		Coywolf
