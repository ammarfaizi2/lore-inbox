Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRKSOeC>; Mon, 19 Nov 2001 09:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279103AbRKSOdx>; Mon, 19 Nov 2001 09:33:53 -0500
Received: from [195.66.192.167] ([195.66.192.167]:43012 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278381AbRKSOdm>; Mon, 19 Nov 2001 09:33:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Mount opts depending on fs type?
Date: Mon, 19 Nov 2001 16:33:31 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111916333103.00817@nemo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I frequently insert/remove hdds from my boxes,
I think it is useful to have conditional mount options
defending on type of detected fs type, something along the lines:

mount -O vfat:a,b,c -O ntfs:.... -o.... device dir

-O fs:opt[=val],opt[=val],...
    Apply these options if filesystem 'fs' is autodetected on device
-o ...
    Apply these always

A similar thing is probably needed for automounter.
Or maybe I am stupid and some script trickery could do it too...
--
vda
