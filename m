Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDQQlZ>; Wed, 17 Apr 2002 12:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSDQQlY>; Wed, 17 Apr 2002 12:41:24 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:8443 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293632AbSDQQlY>; Wed, 17 Apr 2002 12:41:24 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 17 Apr 2002 10:38:57 -0600
To: Domen Stangar <domen.stangar@siol.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to setup loopback before calling mount_root() .. root=/dev/loop0
Message-ID: <20020417163857.GN20464@turbolinux.com>
Mail-Followup-To: Domen Stangar <domen.stangar@siol.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020417181853.00bf1c00@212.118.71.191>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2002  18:24 +0200, Domen Stangar wrote:
> Can anyone please tell me if there is a way to use lo_ioctl before mounting 
> root.
> How to use lo_ioctl in kernel in way like:
> losetup /dev/loop0 /dev/hda3 ?
> then root=/dev/loop0

Set up an initrd which does this exactly.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

