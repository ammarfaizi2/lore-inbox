Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbTCSSWb>; Wed, 19 Mar 2003 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbTCSSWb>; Wed, 19 Mar 2003 13:22:31 -0500
Received: from pdbn-d9bb871b.pool.mediaWays.net ([217.187.135.27]:31751 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S263129AbTCSSW2>;
	Wed, 19 Mar 2003 13:22:28 -0500
Date: Wed, 19 Mar 2003 19:32:39 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Eric Weigle <ehw@lanl.gov>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
Message-ID: <20030319183239.GA24032@citd.de>
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com> <20030319160437.GA22939@citd.de> <1048091858.989.10.camel@bip.localdomain.fake> <Pine.LNX.4.53.0303191158180.31905@chaos> <20030319182354.GP832@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319182354.GP832@lanl.gov>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 11:23:55AM -0700, Eric Weigle wrote:
> Ok, I couldn't help but try it. I've got a 2G bochs disk image for Debian
> (really a 250M holey file) I can copy and throw away.
> 
> A `rm -rfv *` as root from / does:
> 
> (removes a bunch of files, including "rm" from bin and so forth), then loops printing:
> removing all entries of directory `dev/pts'
> removing the directory itself `dev/pts'
> removing all entries of directory `dev/pts'
> removing the directory itself `dev/pts'
> removing all entries of directory `dev/pts'
> removing the directory itself `dev/pts'
> removing all entries of directory `dev/pts'
> removing the directory itself `dev/pts'
> removing all entries of directory `dev/pts'
> removing the directory itself `dev/pts'
> 
> It's apparently having issues with removing the mount point of the devpts
> filesystem.

I think you should try it without devfs. I don't think that you can
 remove directories in devfs. :-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

