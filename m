Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSBIANt>; Fri, 8 Feb 2002 19:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSBIANj>; Fri, 8 Feb 2002 19:13:39 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5390 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287865AbSBIANY>;
	Fri, 8 Feb 2002 19:13:24 -0500
Date: Fri, 8 Feb 2002 16:10:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: EXT2-fs panic on 2.5.4-pre3
Message-ID: <20020209001022.GF27610@kroah.com>
In-Reply-To: <20020208234310.GA27610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208234310.GA27610@kroah.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 11 Jan 2002 21:40:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 03:43:10PM -0800, Greg KH wrote:
> I got this when unmounting my drive after running e2fsck after a kernel
> oops (different problem... :)
> 
> Kernel panic: EXT2-fs panic (device ide0(3,5)): load_block_bitmap: block_group >= groups_count - block_group = 131071, groups_count = 33

Just to be clearer, this happend from a fresh boot.  No oops had
happened, just e2fsck, and then umount, which caused the above panic.

thanks,

greg k-h
