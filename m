Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274886AbRIVBke>; Fri, 21 Sep 2001 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274887AbRIVBkZ>; Fri, 21 Sep 2001 21:40:25 -0400
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:20687 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S274886AbRIVBkM>; Fri, 21 Sep 2001 21:40:12 -0400
Subject: Strange messages
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 21 Sep 2001 21:40:36 -0400
Message-Id: <1001122844.3555.6.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an message from modprobe. I think it's related to agpgart:

Sep 21 19:46:48 tiger crond: crond startup succeeded
Sep 21 19:46:49 tiger xfs: xfs startup succeeded
Sep 21 19:46:49 tiger xfs: listening on port 7100 
Sep 21 19:46:49 tiger xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/CID (unreadable) 
Sep 21 19:46:49 tiger xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/local (unreadable) 
Sep 21 19:46:50 tiger smb: smbd startup succeeded
Sep 21 19:46:50 tiger smb: nmbd startup succeeded
Sep 21 19:46:50 tiger anacron: anacron startup succeeded
Sep 21 19:46:50 tiger atd: atd startup succeeded
Sep 21 19:46:51 tiger linuxconf: Running Linuxconf hooks:  succeeded
Sep 21 19:46:56 tiger modprobe: modprobe: Can't locate module
char-major-226
Sep 21 19:46:56 tiger modprobe: modprobe: Can't locate module
char-major-226
Sep 21 19:46:56 tiger kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Sep 21 19:46:56 tiger kernel: agpgart: Maximum main memory to use for
agp memory: 27M
Sep 21 19:46:56 tiger kernel: agpgart: Detected Intel 440BX chipset
Sep 21 19:46:56 tiger kernel: agpgart: AGP aperture is 64M @ 0xec000000
Sep 21 19:46:57 tiger kernel: [drm] AGP 0.99 on Intel 440BX @ 0xec000000
64MB
Sep 21 19:46:57 tiger kernel: [drm] Initialized radeon 1.1.1 20010405 on
minor 0
Sep 21 19:47:16 tiger gdm(pam_unix)[937]: session opened for user
louisg00 by (uid=0)
Sep 21 19:47:24 tiger gnome-name-server[1067]: starting
Sep 21 19:47:24 tiger gnome-name-server[1067]: name server starting

3D seems to be working. I'm working on a Redhat roswell2 with
kernel-2.4.10pre13.

Louis


