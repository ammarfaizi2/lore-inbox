Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSCVHvM>; Fri, 22 Mar 2002 02:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSCVHvB>; Fri, 22 Mar 2002 02:51:01 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:9993 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S293035AbSCVHux>; Fri, 22 Mar 2002 02:50:53 -0500
Date: Fri, 22 Mar 2002 00:50:37 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: max partition size
Message-ID: <20020322005037.A9256@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who knows for sure what is the current upper limit on ext2/ext3
file system size (4KiB blocks as this is what tools will accept)?  It
definitely is not 1 TB as we were making working partition nearly twice
that.  But practice seems to indicate that 2 TB, or whereabout, can be
too much.  Is this a property of a file system or we bumping into
block device boundaries or this are just tools?

BTW - mke2fs goes most of the way but gets stuck eventually when
writing inode tables if that it is too close to 2 TB.  Yes, there
are people who really want that much of a file system or maybe even
more. :-)   This was not done for a sake of a record.

  Michal

