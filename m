Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283438AbRLWShD>; Sun, 23 Dec 2001 13:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283592AbRLWSgx>; Sun, 23 Dec 2001 13:36:53 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:18563 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S283438AbRLWSgq>; Sun, 23 Dec 2001 13:36:46 -0500
Date: Sun, 23 Dec 2001 13:37:14 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IDE Harddrive Performance
In-Reply-To: <Pine.LNX.4.33.0112230942030.19818-100000@mf1.private>
Message-ID: <Pine.LNX.4.33.0112231332390.5312-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recommend that you check out the smartsuite package described in
> http://www.linux-ide.org/smart.html.  It showed me that when a Maxtor
> drive I recently purchased dropped from 40MB/sec to 1MB/sec throughput, it
> was having an incredible number of "Hardware ECC Recovered" (SMART
> attribute 195) events.  I guess some bit chunk of the magnetic media had

the smart tools are *VERY* useful.  I recently built a raid box and
installed 5 of the disks in one nice fan-equipped bracket.  unfortunately,
100G WD 7200 RPM's vibrate fairly seriously, and this actually caused
horrible performance, as well as a small number of bad low-level writes 
and thus remapped sectors (shown by smartctl).  simply moving some of the
disks elsewhere entirely fixed the problem (120 MB/s!)

regards, mark hahn.

