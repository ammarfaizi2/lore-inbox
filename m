Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTDNLLz (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDNLLz (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:11:55 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:59149
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S262961AbTDNLLx 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 07:11:53 -0400
Date: Mon, 14 Apr 2003 12:23:37 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Russell Nash <russ@nixhelp.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: mkdir on ext3 creates regular file instead of directory
In-Reply-To: <3E9A19D7.6040509@nixhelp.org>
Message-ID: <Pine.LNX.4.21.0304141212350.4376-100000@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003, Russell Nash wrote:

> [1.] One line summary of the problem:
> 
> when using 'mkdir' to create a directory on an ext3 filesystem, a 
> regular file is created instead of the directory.
> 

> 
> Linux version 2.4.20-gentoo-r1 (root@voyager) (gcc version 3.2.2) #2 Sat 
> Apr 5 20:58:27 EST 2003
> 

> 
> [6.] A small shell script or example program which triggers the
>       problem (if possible)
> 
> cd
> rm -rf .variable
> mkdir .variable
> cd .variable
> 

 Russell, mkdir is working fine here (assorted linuxfromscratch
boxen), with what look to be similar versions of the main software.  The
command appears to be part of fileutils (or coreutils), maybe you'll do
better asking on the gentoo lists.

Ken
-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.




