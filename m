Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTLWVUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTLWVUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:20:44 -0500
Received: from mail2.edu.stadia.fi ([193.167.197.21]:52764 "EHLO
	mail2.edu.stadia.fi") by vger.kernel.org with ESMTP id S262094AbTLWVUm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:20:42 -0500
Message-Id: <sfe8cdc2.027@mail2.edu.stadia.fi>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Tue, 23 Dec 2003 23:20:18 +0200
From: "Jari Soderholm" <Jari.Soderholm@edu.stadia.fi>
To: <linux-kernel@vger.kernel.org>
Subject: DEVFS is very good compared to UDEV
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I am quite advanced Linux user who has used DEVFS quite
long time, and have also been a little suprised that it
has been marked OBSOLETE in 2.6 kernel.

I think that there are plenty good arguments why in many
cases it is technically better solution than udev, and
I like to give my view on that.

DEVFS is a really simple to use, compile it into kernel and configure the programs to use DEVFS filenames and thats it.

I think that it is very good that devicename files are out from the disk, one cannot delete those files, disk
errors do not affect the, and searching device files is faster.

Booting kernel is faster compared to UDEV.

And DEVFS has worked for years for me at least very well, I haven't had any problems with it.

I do not understand some opinions that DEVFS uses memory.
Compared to the size of applications people run in linux
, the memory what kernel with DEVFS takes is practically
nonexistent.
I think that files in SYSFS-directory (needed by UDEV) probably take more memory than those in DEVFS-dir.

UDEV otherwise is very complex for average user and it
is definetly much slower , it has much greater chance
for errors because very complicated scrips which seem 
to need many different gnu commandline utilities.

It is quite funny that when DEVFS creates device files
automagically and in the ram-memory, some people want
to go backwards, and use shell scripts to 
create those files on hard disk, and then it is technically better solution.

If one you look at the /sysfs-directory there are
device filenames, (but not the actual devicefiles), so
it does same thing that DEVFS, but actually much worce
way, it created devicefilenames in the ram, but
one cannot use them, because they are not devicefiles.

Why could you develop it so that UDEV could create those
actual device files there also, then most linux
users would not need those horrible scipts anymore.
All that is then needed link from /sysfs to /dev dir.

In my option good operating system kernel should use disk and external programs little as possible.

T Jari Söderholm
jari.soderholm#stadia.fi

