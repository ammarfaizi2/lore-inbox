Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRLAHnD>; Sat, 1 Dec 2001 02:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283986AbRLAHmx>; Sat, 1 Dec 2001 02:42:53 -0500
Received: from cs6669235-16.austin.rr.com ([66.69.235.16]:8576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281489AbRLAHmq>; Sat, 1 Dec 2001 02:42:46 -0500
Date: Sat, 1 Dec 2001 00:47:19 -0600 (CST)
From: Erik Elmore <lk@bigsexymo.com>
X-X-Sender: <lk@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: EXT3 - freeze ups during disk writes
Message-ID: <Pine.LNX.4.33.0112010044020.1024-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since I started using ext3fs, whenever there is a disk write, the 
kernel sucks up all of the CPU thereby preempting everything and causing 
the PC to freeze momentarily.  Could this possibly be caused by the 
journaling code in ext3?

-Erik



