Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSHVH3Z>; Thu, 22 Aug 2002 03:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSHVH3Z>; Thu, 22 Aug 2002 03:29:25 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:44713 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S317695AbSHVH3Y>;
	Thu, 22 Aug 2002 03:29:24 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Combined performance patches for 2.4.19
Date: Thu, 22 Aug 2002 17:33:05 +1000
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208221733.29976.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After the positive feedback from users with my patch for 2.4.18 and requests 
for the latest kernel I've combined the following patches:

O(1) scheduler
Preemptible

These are based on the latest patches available for the 2.4.19 kernel. I will 
be merging the latest low latency patch soon also. It seems to work nicely so 
far, but would be interested to know how others fare. I've not tried SMP as I 
dont have an SMP machine.

The combined patch against 2.4.19 (and now a diff patch for preemptible on top 
of O(1)) can be found here:

http://kernel.kolivas.net

Thanks again to all the real kernel developers for making this possible

Con Kolivas

P.S. Please CC me as not subscribed to LKML.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ZJO+F6dfvkL3i1gRAsSLAJ0Qg7My/e45ZOdoYoKNcf9OLUgudwCfenhZ
mjDg76DW3QLXuC4PT4sf8lI=
=apfI
-----END PGP SIGNATURE-----
