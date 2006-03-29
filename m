Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWC2Ozw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWC2Ozw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWC2Ozv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:55:51 -0500
Received: from tag.witbe.net ([81.88.96.48]:37042 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1750751AbWC2Ozv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:55:51 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'OGAWA Hirofumi'" <hirofumi@mail.parknet.co.jp>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat: kill reserved names
Date: Wed, 29 Mar 2006 16:55:41 +0200
Organization: Witbe.net
Message-ID: <000701c65340$d9736ab0$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZTPF2X39N3rx+/QXStPt14L5szOQABEREg
In-Reply-To: <87k6ade3ei.fsf@duaron.myhome.or.jp>
x-ncc-regid: fr.witbe
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Since these names on old MSDOS is used as device, so, current fat
> driver doesn't allow a user to create those names.  But many OSes and
> even Windows can create those names actually, now.
> 
> This patch removes the reserved name check.
> 
> -/* MS-DOS "device special files" */
> -static const unsigned char *reserved_names[] = {
> -	"CON     ", "PRN     ", "NUL     ", "AUX     ",
> -	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
> -	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
> -	NULL

Please don't :

Microsoft Windows XP [Version 5.1.2600]
(C) Copyright 1985-2001 Microsoft Corp.

D:\>mkdir LPT1
The directory name is invalid.

Windows doesn't want these !!!

Regards,
Paul

