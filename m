Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTDWAFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTDWAFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:05:33 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:23488 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263915AbTDWAFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:05:32 -0400
Date: Tue, 22 Apr 2003 20:24:00 -0400
To: ed.sweetman@umich.edu, vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 state of matroxfb
Message-ID: <20030423002400.GA221@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using the matroxfb drivers at
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/
for the last 3 months with good luck. (G400, single monitor, 
using text console and X).

Linux rushmore 2.5.68-mm1 #1 Sun Apr 20 19:45:04 EDT 2003 i686 unknown

Besides the other 2.5.x changes for video/console
documented by davej at http://www.codemonkey.org.uk/post-halloween-2.5.txt
matroxfb wants "matroxfb" in the boot string, rather than "matrox".

My current append directive for lilo includes:
video=matroxfb:vesa:depth:32,fh:115,fv:92,xres:1920,yres:1440,left:392,right:124
But don't use that string, as most monitors cannot handle it.  It happens to be
for a ViewSonic PF815.  (other than "fb" in "matroxfb", the same string 
is what I was using with 2.4.x).

Perhaps it's easier for Petr to maintain matroxfb outside Linus' tree
at the moment.  I'm glad he keeps putting his patches up.  
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

