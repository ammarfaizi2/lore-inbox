Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293643AbSCKIrS>; Mon, 11 Mar 2002 03:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCKIrI>; Mon, 11 Mar 2002 03:47:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57838
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293643AbSCKIqt>; Mon, 11 Mar 2002 03:46:49 -0500
Date: Mon, 11 Mar 2002 00:47:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Meusel <meusel@codixx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2/3 uid/gid support
Message-ID: <20020311084741.GC311@matchmail.com>
Mail-Followup-To: Erik Meusel <meusel@codixx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16j1Z6-0002xf-00@the-village.bc.nu> <02031109444400.00601@huschki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02031109444400.00601@huschki>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 09:44:44AM +0100, Erik Meusel wrote:
> Hi.
> 
> Just one little question:
> 
> Why do ext2 and ext3 not support mount options uid and gid as all the
> other  filesystems do?
> 

because they have uid and gid within the filesystem itself for directories,
files, pipes, etc stored in the inodes of the fs.  Same with any other posix
filesystem (which vfat, iso9660(not counting rockridge), hfs, etc are *not*).

Mike
