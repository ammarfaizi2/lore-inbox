Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSEYPii>; Sat, 25 May 2002 11:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSEYPih>; Sat, 25 May 2002 11:38:37 -0400
Received: from smtp03.wxs.nl ([195.121.6.37]:11185 "EHLO smtp03.wxs.nl")
	by vger.kernel.org with ESMTP id <S314686AbSEYPih>;
	Sat, 25 May 2002 11:38:37 -0400
Message-ID: <3CEFAC3E.3C631F37@wxs.nl>
Date: Sat, 25 May 2002 17:22:38 +0200
From: Gert Vervoort <Gert.Vervoort@wxs.nl>
Organization: Planet Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
In-Reply-To: <3CEF8815.C7C13D39@wxs.nl> <20020525150859.2335c10a.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege wrote:

> Well... this is a _compile_ fix... ;)
> But when you boot a kernel with this patch... it hangs directly after
> SCSI subsystem driver Revision: X.YZ
> 

Yes indeed, I should have tested it first 8-(.

New patch sended to the list, this one actually boots:

[gert@viper gert]$ uname -a
Linux viper 2.5.18 #4 Sat May 25 16:14:17 CEST 2002 i686 unknown
[gert@viper gert]$ cdrecord -scanbus
Cdrecord 1.11a23 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Linux sg driver version: 3.5.25
Using libscg version 'schily-0.6'
scsibus0:
	0,0,0	  0) 'PHILIPS ' 'PCA460RW        ' '1.0g' Removable CD-ROM
	0,1,0	  1) *
	0,2,0	  2) *
	0,3,0	  3) *
	0,4,0	  4) *
	0,5,0	  5) *
	0,6,0	  6) *
	0,7,0	  7) *
[gert@viper gert]$
