Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292718AbSBUTKV>; Thu, 21 Feb 2002 14:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292728AbSBUTKL>; Thu, 21 Feb 2002 14:10:11 -0500
Received: from x101-185-43-dhcp.reshalls.umn.edu ([128.101.185.43]:48281 "EHLO
	minerva") by vger.kernel.org with ESMTP id <S292727AbSBUTJ7>;
	Thu, 21 Feb 2002 14:09:59 -0500
Date: Thu, 21 Feb 2002 13:09:50 -0600
From: Matt Reppert <matt@nyu.dyn.dhs.org>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW
Message-Id: <20020221130950.234a373b.matt@nyu.dyn.dhs.org>
In-Reply-To: <1014313262.8811.25.camel@unaropia>
In-Reply-To: <1014313262.8811.25.camel@unaropia>
Organization: Arashi no Kaze
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2002 12:40:35 -0500
Shawn Starr <spstarr@sh0n.net> wrote:
<snip>
>
> When i attempt to mount /dev/cdrom (symlink to /dev/scd0) I get
> 
> mount: /dev/cdrom is not a valid block device (or /dev/scd0).
> 
> What broke? :-(

I got this problem also. Similar config, ATAPI Plextor CDRW using ide-scsi.
The system would refuse to read/mount CDs unless I did it as root. (eg,
cds wouldn't mount, cdparanoia wouldn't work) Upgrading to -rc2-ac1 seems
to have "fixed" it, have you tried -rc2? (I should try to figure out why
after class, when I actually have time :3 )
--
Matt
