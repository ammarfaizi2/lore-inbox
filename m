Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTIIUIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:08:53 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:23278 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264429AbTIIUIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:08:52 -0400
Date: Tue, 9 Sep 2003 14:07:51 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode generation numbers
Message-ID: <20030909140751.E18851@schatzie.adilger.int>
Mail-Followup-To: Bernd Schubert <bernd-schubert@web.de>,
	linux-kernel@vger.kernel.org
References: <200309092108.37805.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309092108.37805.bernd-schubert@web.de>; from bernd-schubert@web.de on Tue, Sep 09, 2003 at 09:08:37PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 09, 2003  21:08 +0200, Bernd Schubert wrote:
> for a user space nfs-daemon it would be helpful to get the inode generation 
> numbers. However it seems the fstat() from the glibc doesn't support this, 
> but refering to some google search fstat() from some (not all) other unixes 
> does.
> Does anyone know how to read those numbers from userspace with linux?

For ext2/ext3 filesystems you can use EXT2_GET_VERSION ioctl for this.
Maybe reiserfs as well.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

