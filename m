Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSDCKoF>; Wed, 3 Apr 2002 05:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSDCKnz>; Wed, 3 Apr 2002 05:43:55 -0500
Received: from monster.gotadsl.co.uk ([213.208.127.236]:62087 "EHLO
	monster.gotadsl.co.uk") by vger.kernel.org with ESMTP
	id <S310435AbSDCKnj>; Wed, 3 Apr 2002 05:43:39 -0500
Subject: Re: Question about 'Hidden' Directories in ext2
From: Craig Knox <crg@monster.gotadsl.co.uk>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 03 Apr 2002 11:53:59 +0100
Mime-Version: 1.0
X-Scanner: VirusScanner *16siBr-0005YD-00*oGYy.1w6HnU*
Message-Id: <20020403104348Z310435-617+3433@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-02 at 23:16, Calin A. Culianu wrote:
> 
> Ok, so some hackers broke into one of our boxes and set up an ftp site.
> They monopolized over 70gb of hard drive space with warez and porn.  We
> aren't really that upset about it, since we thought it was kind of funny.
> (Of course we don't like the idea that they are using out bandwidth and
> disk space, but we can easily remedy that).
> 
> Anyway, the weird thing is they created 2 directories, both of which were
> strangely hidden.  You can cd into them but you can't ls them.  I
> 
> /usr/lib/ypx and /usr/man/ypx were the two directories that contained both
> the ftp software and the ftp root.  When you are in /usr/man and you do an
> ls, you don't see the ypx directory (same when you are in /usr/lib).  The
> ls binary we got is right off the redhat cd so it shouldn't still be
> compromised by whatever rootkit was installed.
> 
> My question is this: can the data structures in ext2fs be somehow hacked
> so a directory can't appear in a listing but can be otherwise located for
> a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
> of the rootkit...

If you are using the binary "ls" of the redhat CD they are probably
using a kernel module to hide this directory.
Have you tried running -> http://www.chkrootkit.org on the box?


