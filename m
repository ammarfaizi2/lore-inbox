Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSBMG3c>; Wed, 13 Feb 2002 01:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBMG3W>; Wed, 13 Feb 2002 01:29:22 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:63204 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S291401AbSBMG3P>; Wed, 13 Feb 2002 01:29:15 -0500
Date: Wed, 13 Feb 2002 08:20:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: portmap problems with 2.5.4-pre5
Message-ID: <Pine.LNX.4.44.0202130818430.15774-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to mount an NFS filesystem and had mount stuck in the D state for 
quite a while (minutes), this was also in my logs.

Jan  1 02:06:00 mondecino kernel: portmap: server localhost not responding, timed out
Jan  1 02:06:00 mondecino kernel: lockd_up: makesock failed, error=-5
Jan  1 02:07:40 mondecino kernel: portmap: server localhost not responding, timed out

Eventually it did mount, but i've never had this error before on that box 
(i use the box daily and do that mount more than 5 times a day). I've been 
using 2.5 on that box since 2.5.0. I seem to be able to reproduce it, so 
i'll leave the box running in case anyone wants to try anything.

box: RH 7.2 w/ 2.5.4-pre5

Cheers,
	Zwane Mwaikambo

