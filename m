Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTKTVLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTKTVLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:11:36 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:34286 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262051AbTKTVLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:11:35 -0500
Date: Thu, 20 Nov 2003 14:07:39 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Timothy Miller <miller@techsource.com>
Cc: Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031120140739.I20568@schatzie.adilger.int>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Justin Cormack <justin@street-vision.com>,
	Jesse Pollard <jesse@cats-chateau.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com> <3FBD27A0.50803@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FBD27A0.50803@techsource.com>; from miller@techsource.com on Thu, Nov 20, 2003 at 03:44:16PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2003  15:44 -0500, Timothy Miller wrote:
> This could be a problem if COW causes you to run out of space when 
> writing to the file.

Not much different than running out of space copying a file.

> This could also be a benefit if, for whatever reason, you have lots of 
> copies of the same file that you never change.  But that sounds somewhat 
> pointless to me.

Umm, snapshots-in-time of your /home, /usr/src, etc?  Copies of the kernel?
Lots of reasons to have mostly-identical versions of files.  Almost like
hard links, except you aren't at the mercy of your editor/patch to do the
right thing when modifying one of those copies.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

