Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbTATUkC>; Mon, 20 Jan 2003 15:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTATUkC>; Mon, 20 Jan 2003 15:40:02 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:54258 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S266975AbTATUkB>; Mon, 20 Jan 2003 15:40:01 -0500
Date: Mon, 20 Jan 2003 13:48:31 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: David Schwartz <davids@webmaster.com>
Cc: david.lang@digitalinsight.com, dana.lacoste@peregrine.com,
       linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030120134831.Q1594@schatzie.adilger.int>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	david.lang@digitalinsight.com, dana.lacoste@peregrine.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301201129510.6894-100000@dlang.diginsite.com> <20030120201904.AAA25148@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030120201904.AAA25148@shell.webmaster.com@whenever>; from davids@webmaster.com on Mon, Jan 20, 2003 at 12:19:02PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 20, 2003  12:19 -0800, David Schwartz wrote:
> On Mon, 20 Jan 2003 11:31:53 -0800 (PST), David Lang wrote:
> >so are you saying it's illegal for an opensource project to use a
> >commercial version control system, or that use of such a version
> >control
> >system by a GPL project forces the company to GPL their version
> >control system?
> 
> 	First, what is the preferred form of a work for making modifications 
> to it? Here, I argue that if a project is based around a version 
> control system, then checking out the source code removes vital 
> metainformation and does not produce the preferred form. The loss of 
> the check in explanations and change history makes modifications more 
> difficult.

So, let's say that CVS is the "preferred form" of the Linux kernel source
code, because it is freely available.  If BK has everything in it that CVS
does, and also information that is not even POSSIBLE to store in CVS (i.e.
ChangeSet information which links a bunch of individual file changes and
comments into a single change entity) what happens then?  If you had never
put the kernel into BK, that information wouldn't exist at all, yet it is
not possible to extract it without resorting to some source-of-all-evil
tool like BK (I hope everyone reading here understands the sarcasm, but the
fact that I have to annotate it makes me believe some people will not).

The fact that BK is used creates information which WOULD NOT HAVE EXISTED
had BK not existed.  In fact, until BK was in use by Linus, not even basic
CVS checkin comments existed, so the metadata was in a format called
linux-kernel mbox (if that).  So, the use of a tool like BK makes more data
available, but people cannot be worse off than when the kernel was shipped
as a tarball and periodic patches.  For the sake of those people who don't
or can't use BK, just pretend BK doesn't exist and they will not be any
worse off than a year ago.

> 	I submit that it is impossible to comply with the GPL and distribute 
> binaries if the preferred form of a work for the purposes of making 
> modifications to it is in a proprietary file format. This is 
> tantamount to encrypting the source.

Sure, except BK isn't a proprietary file format (see GNU CSSC and or some
Perl scripts reported on this list), so the issue is purely hypothetical.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

