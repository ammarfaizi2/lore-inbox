Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSGHS0n>; Mon, 8 Jul 2002 14:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSGHS0m>; Mon, 8 Jul 2002 14:26:42 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:65461 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317054AbSGHS0k>; Mon, 8 Jul 2002 14:26:40 -0400
Message-Id: <5.1.0.14.2.20020708192448.028f5ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Jul 2002 19:30:00 +0100
To: Axel Siebenwirth <axel@hh59.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: NTFS: 2.0.15 - Fake inodes based attribute i/o via the
  page cache, fixes, cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020708180423.GA4676@neon.hh59.org>
References: <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
 <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:04 08/07/02, Axel Siebenwirth wrote:
>Is it still the lack of information on the filesystem from Microsoft?

No, we have a pretty good idea of ntfs now. But it is a complicated fs and 
when writing you need to take care of a lot of things simultaneously or you 
corrupt the volume. ntfs is organized as a transactional, relational 
database , hence there is a lot of book keeping involved in modifyin any 
structure. Even without supporting the journal (we will not support it at 
least initially...) almost all data is duplicated in various places and if 
you forget to update something somewhere when updating it elsewhere you 
basically make salad of the metadata and the probability is quite high that 
you end up killing the data on the volume either in part or completely...

Finally I am busy with my PhD and I have two part time jobs as well so I 
don't have much time to develop ntfs... As always with free software 
development, it goes slowly...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

