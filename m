Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSGDOcl>; Thu, 4 Jul 2002 10:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSGDOck>; Thu, 4 Jul 2002 10:32:40 -0400
Received: from mail45-s.fg.online.no ([148.122.161.45]:18917 "EHLO
	mail45.fg.online.no") by vger.kernel.org with ESMTP
	id <S317423AbSGDOci> convert rfc822-to-8bit; Thu, 4 Jul 2002 10:32:38 -0400
Subject: df on a nfs mounted share vs local?
From: "Nils O." =?ISO-8859-1?Q?Sel=E5sdal?= <noselasd@frisurf.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1025793209.10267.5.camel@space>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jul 2002 16:35:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering, how come df reports
root:~# df /mnt/export/
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda5              2562252    383792   2178460  15% /mnt/export
on the server, while on a client that mounts /mnt/export over nfs:
[root@space download]# df /mnt/nfs/
Filesystem           1k-blocks      Used Available Use% Mounted on
lfs:/mnt/export        2562256    383792   2178464  15% /mnt/nfs

Just a few blocks diffrent, but I've seen much bigger.. also seen +/-
a few % on "Use"

-- 
Nils Olav Selåsdal <NOS@Utel.no>
System Developer, UtelSystems a/s
w w w . u t e l s y s t e m s . c o m


