Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUDVTwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUDVTwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUDVTun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8911 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264653AbUDVTuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:12 -0400
Date: Thu, 22 Apr 2004 21:47:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: executable archive
Message-ID: <20040422194702.GA2595@openzaurus.ucw.cz>
References: <1082462304.27255.76.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082462304.27255.76.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Same problem with python (i'm just learning), and a collection of .class
> files for java. 

For java its called .jar.

> My first though would be to make a stub, and put the ar file in the data
> area of the process, something akind to self extracting zip files on
> dos/windoze.
> A couple of problems: 
> a) you can't "mount" the ar file to make it visible to the process as a
> part of it's file system view. ( Atleast not without intercepting a
> whole lot of libc calls) 

See uservfs.sf.net.

But intercepting those system calls would be better, portable to macOsX etc...

Or simply link those interpretters with uservfs; its going to be
usefull for other stuff, too.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

