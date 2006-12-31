Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLaAMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLaAMF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 19:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWLaAMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 19:12:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42245 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbWLaAME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 19:12:04 -0500
Date: Sun, 31 Dec 2006 00:12:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Rik van Riel <riel@redhat.com>
Cc: Alexander Nagel <feuerschwanz76@web.de>, linux-kernel@vger.kernel.org
Subject: Re: new harddrive with media error
Message-ID: <20061231001201.GT17561@ftp.linux.org.uk>
References: <en6q3j$2jk$1@sea.gmane.org> <4596F760.9010105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4596F760.9010105@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 06:33:52PM -0500, Rik van Riel wrote:
> Alexander Nagel wrote:
> >Hi all,
> >
> >i installed a new drive (WDC WD5000KS-00M) in my computer and installed 
> >WinXP on it. Afterwards i installed Debian etch on the second one 
> >(HDS722512VLSA80). Everything works fine so far, but during every boot i 
> >get following messages in dmesg [1]
> >Kernel [2] is 2.6.18 as default kernel in etch.
> >the board is a asusboard with via chipset [3]
> >The problem is that the boottime is very long, for every "media error" ~ 
> >3 sec. :-(
> 
> That's because your hard disk has errors.
> 
> Maybe not on the whole disk, but some parts of the disk are
> certainly broken.  It's a good thing you discovered this so
> soon after installation, and are not relying on it yet with
> all your personal data.
> 
> You'll want to exchange the disk for one without media errors.

>From the look of it, I'd say that it's size reported by disk being
more than what's accessible.  Take a look at the block numbers...
