Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVKLAuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKLAuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKLAuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:50:20 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:50135 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750822AbVKLAuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:50:19 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [patch] mark text section read-only
To: coywolf@sosdg.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       ak@suse.de, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Sat, 12 Nov 2005 00:03:51 +0100
References: <56cTZ-2PF-5@gated-at.bofh.it> <56cTZ-2PF-3@gated-at.bofh.it> <56fRE-7wr-21@gated-at.bofh.it> <56gaT-7Un-17@gated-at.bofh.it> <57DHW-jb-21@gated-at.bofh.it> <57DHW-jb-19@gated-at.bofh.it> <57Mia-4BG-5@gated-at.bofh.it> <57MrY-50s-39@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Eahvz-0001gP-Uc@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@sosdg.org> wrote:

> +++ 2.6.14-mm2-cy/init/main.c        2005-11-12 02:50:45.000000000 +0800
...
> +void mark_text_ro(void)
...
> +     printk ("Write protecting the kernel text data: %luk\n",
> +                     (unsigned long)(_etext - _text) >> 10);

This message should have a priority level, shouldn't it?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
