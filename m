Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272056AbRH2TXP>; Wed, 29 Aug 2001 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272060AbRH2TXF>; Wed, 29 Aug 2001 15:23:05 -0400
Received: from [195.66.192.167] ([195.66.192.167]:37385 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272056AbRH2TWs>; Wed, 29 Aug 2001 15:22:48 -0400
Date: Wed, 29 Aug 2001 22:21:54 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <19318081209.20010829222154@port.imtp.ilyichevsk.odessa.ua>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re[4]: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
In-Reply-To: <200108291427.f7TERJj07458@vindaloo.ras.ucalgary.ca>
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
 <20010829021304.D24270@turbolinux.com>
 <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
 <200108291427.f7TERJj07458@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

Wednesday, August 29, 2001, 5:27:19 PM, you wrote:
RG> You say you are running devfs. Well, if that's the case, you can
RG> simply do:
RG> # fsck /dev/root

RG> because devfs makes /dev/root a symbolic link to the root FS device.
RG> Magic.

Thanks! It works!
However, I still think "fsck /" behavior isn't right - people who don't use
devfs won't be able to check root fs without fstab entry for it.
This seems fixable - "mount -o remount,rw /" works without /dev/root
trick, right?

Best regards,
VDA
--
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


