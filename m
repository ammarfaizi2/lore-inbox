Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131081AbRCJSCN>; Sat, 10 Mar 2001 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131083AbRCJSCE>; Sat, 10 Mar 2001 13:02:04 -0500
Received: from bretweir.total.net ([154.11.89.176]:34752 "HELO
	smtp.interlog.com") by vger.kernel.org with SMTP id <S131081AbRCJSBx>;
	Sat, 10 Mar 2001 13:01:53 -0500
Message-ID: <3AAA6C3E.B8AD02E7@interlog.com>
Date: Sat, 10 Mar 2001 13:02:38 -0500
From: Douglas Gilbert <dgilbert@interlog.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Harald Dunkel <harri@synopsys.COM>
Subject: Re: aic7xxx of 2.4.2: 'cdrecord -scanbus' complains about DVD
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> When I run 'cdrecord -scanbus', then cdrecord complains about my
> DVD:
> 
> # cdrecord -scanbus
> Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
> Linux sg driver version: 3.1.17
> Using libscg version 'schily-0.1'
> scsibus0:
>         0,0,0     0) *
>         0,1,0     1) *
> cdrecord: Warning: controller returns wrong size for CD capabilities page.
>         0,2,0     2) 'PIONEER ' 'DVD-ROM DVD-303 ' '1.09' Removable CD-ROM
>         0,3,0     3) *
>         0,4,0     4) 'PIONEER ' 'CD-ROM DR-U16S  ' '1.01' Removable CD-ROM
>         0,5,0     5) *
>
> Is this warning correct? Or is this a problem of cdrecord?

This is noise coming out of cdrecord and not a aic7xxx, sg
or linux issue. I believe Joerg Schilling is pointing out 
that the device in question is at variance with some standard 
or convention. The subject has been raised on the cdwrite list.

Doug Gilbert
