Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273228AbRIJGph>; Mon, 10 Sep 2001 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273229AbRIJGp1>; Mon, 10 Sep 2001 02:45:27 -0400
Received: from stine.vestdata.no ([195.204.68.10]:31376 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S273228AbRIJGpQ>; Mon, 10 Sep 2001 02:45:16 -0400
Date: Mon, 10 Sep 2001 08:45:26 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: John Ripley <jripley@riohome.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
Message-ID: <20010910084526.A31660@vestdata.no>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua> <3B9B80E2.C9D5B947@riohome.com> <3B9B9917.DA1CC12F@riohome.com> <1000057292.1867.1.camel@nomade> <3B9C1767.2A35BFD2@riohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9C1767.2A35BFD2@riohome.com>; from jripley@riohome.com on Mon, Sep 10, 2001 at 02:29:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 02:29:11AM +0100, John Ripley wrote:
> My thinking was that I've managed to run out of space on all of the
> partitions in the past and had to prune a lot of stuff... so nearly all
> the blocks should contain at least some "likely" data. Still, I guess I
> need to verify that this isn't distorting the results. The program needs
> to recurse over all files on the filesystem rather than all blocks on a
> partition.

You can find a program that does that at:
http://www.stud.ntnu.no/~ragnarkj/download/duplicates.tgz

And results from running on a few different filesystem-types (webpages,
users home directories, softwareand so on) were posted to reiserfs-list
long time ago - look in the archives if you're curious.



-- 
Ragnar Kjørstad
Big Storage
