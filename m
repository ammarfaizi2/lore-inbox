Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbVGIHsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbVGIHsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVGIHsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:48:25 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:49024 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S263158AbVGIHsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:48:23 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: [PATCH 1/14 2.6.13-rc2-mm1] V4L BTTV input
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Reply-To: 7eggert@gmx.de
Date: Sat, 09 Jul 2005 09:48:21 +0200
References: <4obHF-31f-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DrA4U-00018S-HA@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:

> Changes to comply with CodingStyle: // comments converted to /* */

> +        [ 22 ] = KEY_SUBTITLE,                /* CC */
> +        [ 13 ] = KEY_TEXT,                /* TTX */
> +        [ 11 ] = KEY_TV,                /* AIR/CBL */
> +        [ 17 ] = KEY_PC,                /* PC/TV */

Tabs after non-tabs don't work out on tabsizes other than 8,
especialli when intermixed with blanks.

I know CodingStyle doesn't require to support ts!=8, so this is just FYI.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
