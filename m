Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWGLU5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWGLU5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWGLU5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:57:10 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:42980 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751248AbWGLU5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:57:08 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
To: Pavel Machek <pavel@ucw.cz>, Michael Buesch <mb@bu3sch.de>,
       Jeff Garzik <jgarzik@pobox.com>, yi.zhu@intel.com,
       jketreno@linux.intel.com, Netdev list <netdev@vger.kernel.org>,
       linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 12 Jul 2006 22:56:15 +0200
References: <6x7TQ-87H-17@gated-at.bofh.it> <6x8df-8wm-13@gated-at.bofh.it> <6xbaZ-4NX-1@gated-at.bofh.it> <6xyhj-5Fq-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G0ll6-0000vg-19@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> +++ linux-mm/drivers/net/wireless/ipw2200.c 

These are all uses of needs_reinit:

> +static int needs_reinit = 1;

> +             needs_reinit = 1;

I asume there is something missing.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
