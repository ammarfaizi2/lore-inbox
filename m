Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312070AbSCTJYo>; Wed, 20 Mar 2002 04:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312075AbSCTJYe>; Wed, 20 Mar 2002 04:24:34 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5139 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312070AbSCTJYW>; Wed, 20 Mar 2002 04:24:22 -0500
Message-Id: <200203200922.g2K9M0X03611@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: NTFS+koi8-r: "file exists but can't be statted"
Date: Wed, 20 Mar 2002 11:21:32 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

[I can't reach you directly, hope you read this on lkml]

Today I sorted out UNICODE -> koi8-r filename translation
and now I'm able to mount NTFS volumes and see Cyrillic filenames.
However, when I enter my MP3 fold^Wdirectory in Midnight Commander
it complains that it cannot stat two files (DDT-Rain.MP3 and 
DDT-Last_autumn.MP3, actual names are in Cyrillic). Other files
(there are lots of them) are visible.

My mount options are:
ro,iocharset=koi8-r,noatime

I can provide any additional info you need, just ask.
--
vda
