Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRCFX2J>; Tue, 6 Mar 2001 18:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRCFX17>; Tue, 6 Mar 2001 18:27:59 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:2151 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S129667AbRCFX1s>; Tue, 6 Mar 2001 18:27:48 -0500
Date: Tue, 6 Mar 2001 18:27:21 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l03130313b6cad51a8439@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10103061450420.24950-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> itself is a bad thing, particularly given the amount of CPU overhead that
> IDE drives demand while attached to the controller (orders of magnitude
> higher than a good SCSI controller) - the more overhead we can hand off to

I know this is just a troll by a scsi-believer, but I'm biting anyway.

on current machines and disks, ide costs a few % CPU, depending on 
which CPU, disk, kernel, the sustained bandwidth, etc.  I've measured
this using the now-trendy method of noticing how much the IO costs
a separate, CPU-bound benchmark: load = 1 - (unloadedPerf / loadedPerf).
my cheesy duron/600 desktop typically shows ~2% actual cost when running
bonnie's block IO tests.

