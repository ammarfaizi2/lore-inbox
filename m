Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRCJP3n>; Sat, 10 Mar 2001 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131021AbRCJP3d>; Sat, 10 Mar 2001 10:29:33 -0500
Received: from tamago.synopsys.com ([204.176.20.21]:23974 "EHLO
	tamago.synopsys.com") by vger.kernel.org with ESMTP
	id <S131020AbRCJP3X>; Sat, 10 Mar 2001 10:29:23 -0500
Message-ID: <3AAA4825.4BB65463@Synopsys.COM>
Date: Sat, 10 Mar 2001 16:28:37 +0100
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aic7xxx of 2.4.2: 'cdrecord -scanbus' complains about DVD
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

When I run 'cdrecord -scanbus', then cdrecord complains about my
DVD:

# cdrecord -scanbus
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
cdrecord: Warning: controller returns wrong size for CD capabilities page.
        0,2,0     2) 'PIONEER ' 'DVD-ROM DVD-303 ' '1.09' Removable CD-ROM
        0,3,0     3) *
        0,4,0     4) 'PIONEER ' 'CD-ROM DR-U16S  ' '1.01' Removable CD-ROM
        0,5,0     5) *
[snip]


Is this warning correct? Or is this a problem of cdrecord? 


Regards

Harri
