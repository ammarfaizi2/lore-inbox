Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312086AbSCQSKI>; Sun, 17 Mar 2002 13:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312090AbSCQSJ7>; Sun, 17 Mar 2002 13:09:59 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:5043 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312086AbSCQSJx>; Sun, 17 Mar 2002 13:09:53 -0500
Date: Sun, 17 Mar 2002 12:19:54 +0100
From: Felix Braun <Felix.Braun@mail.McGill.ca>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: devfs mounted twice in linux 2.4.19-pre3
Message-Id: <20020317121954.390bc242.Felix.Braun@mail.McGill.ca>
Organization: Vectrix -- Legal Department
X-Mailer: Sylpheed version 0.7.4claws1 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I just noticed that devfs is listed twice in /proc/mounts in linux
2.4.19-pre3, which confuses my shutdown script. Under 2.4.19-pre my
/proc/mounts looks like this:

devfs /dev devfs rw 0 0
/dev/ide/host0/bus0/target0/lun0/part5 / reiserfs rw 0 0
none /dev devfs rw 0 0
/proc /proc proc rw 0 0
/dev/discs/disc0/part1 /dos vfat rw 0 0
/dev/discs/disc0/part9 /opt reiserfs rw,noatime 0 0
none /dev/pts devpts rw 0 0
/dev/discs/disc0/part7 /usr reiserfs rw 0 0
none /dev/shm tmpfs rw 0 0

whereas under 2.4.18 the first line didn't show up. Is that a
misconfiguration on my part?

Bye
Felix
