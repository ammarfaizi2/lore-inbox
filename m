Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143375AbREKT45>; Fri, 11 May 2001 15:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143372AbREKT4s>; Fri, 11 May 2001 15:56:48 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:59654 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S143374AbREKT4h>; Fri, 11 May 2001 15:56:37 -0400
From: dth@trinity.hoho.nl (Danny ter Haar)
Subject: Re: Linux 2.4.4-ac7
Date: Fri, 11 May 2001 19:56:44 +0000 (UTC)
Organization: Holland Hosting
Message-ID: <9dhg5s$1n4$1@voyager.cistron.net>
In-Reply-To: <E14yDLv-0000v7-00@the-village.bc.nu> <20010511193605.A1160@marek.almaran.home>
X-Trace: voyager.cistron.net 989611004 1764 195.64.82.84 (11 May 2001 19:56:44 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010511193605.A1160@marek.almaran.home>,
>is the EXTRAVERSION set properly in Makefile? I use the http://www.bzim=
>age.org
>intermediate diff (chosen ~40K to ~2M) from ac6 nd I still have
>2.4.4-ac6 login prompt (and Makefile says: EXTRAVERSION =3D -ac6).

>From the original patch (agains vanilla 2.4.4)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/Make
file linux.ac/Makefile
--- linux.vanilla/Makefile      Mon Apr 30 15:13:07 2001
+++ linux.ac/Makefile   Wed May  9 21:45:31 2001
@@ -1,11 +1,18 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 4
-EXTRAVERSION =
+EXTRAVERSION = -ac6

So yeah, Alan forgot to increment the Makefile


I happen to make the intermediate diffs on bzimage.org by hand.
If i bump it now, next patch won't apply clean.
So i'll leave it like this. ;-)

Danny

-- 
Holland Hosting
www.hoho.nl      info@hoho.nl

