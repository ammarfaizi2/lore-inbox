Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317926AbSGZSQG>; Fri, 26 Jul 2002 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSGZSQG>; Fri, 26 Jul 2002 14:16:06 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:54255 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317926AbSGZSQF>; Fri, 26 Jul 2002 14:16:05 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 26 Jul 2002 12:17:35 -0600
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
Message-ID: <20020726181735.GD2746@clusterfs.com>
Mail-Followup-To: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
	linux-kernel@vger.kernel.org
References: <3D418DFD.8000007@deming-os.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D418DFD.8000007@deming-os.org>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2002  10:59 -0700, Russell Lewis wrote:
> I have spent some time working on AIX, which pages its kernel memory. 
> It pins the interrupt handler functions, and any data that they access, 
> but does not pin the other code.
> 
> I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
> this, so I can better understand the system.

Because it is complex.  Linus would rather the kernel stay small and non
pageable, rather than grow large enough to need paging (which will in
itself add even more size to the kernel).

I'm sure I've read postings on the subject on l-k, but it would be hard
to find.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

