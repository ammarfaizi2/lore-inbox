Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265009AbSJVTjC>; Tue, 22 Oct 2002 15:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265010AbSJVTjC>; Tue, 22 Oct 2002 15:39:02 -0400
Received: from chunk.voxel.net ([207.99.115.133]:48310 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S265009AbSJVTjA>;
	Tue, 22 Oct 2002 15:39:00 -0400
Date: Tue, 22 Oct 2002 15:45:11 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac1
Message-ID: <20021022194511.GA29525@chunk.voxel.net>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the patch <http://chunk.mp3revolution.net/lvm2/patches/09.patch>
is necessary for Joe's older stuff; otherwise, dm oopses (with
2.5.44, anyways; have not yet tried -ac1).  If you don't merge any of
the newer DM stuff, please at least fix the lack of gendisk
initialization...

On Tue, Oct 22, 2002 at 01:27:06PM -0400, Alan Cox wrote:
> 
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
> 
>    Doug's scsi changes broke mptfusion. I've not looked into that yet
>    also u14f/u34f, and the host changes broke all 5380 based devices
> 
>    This one builds, its not yet had any measurable testing
> 
> Linux 2.5.44-ac1
> -	Resync with Linus 2.5.43/44
> o	Fix net/ipv4/raw.c build problem		(me)
> o	Fix bluetooth pcmcia builds			(me)
> o	Fix dm includes					(me)
> 	| I've not merged any of the DM updates yet
[...]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson
