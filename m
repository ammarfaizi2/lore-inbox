Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132111AbRC1SOr>; Wed, 28 Mar 2001 13:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132112AbRC1SOh>; Wed, 28 Mar 2001 13:14:37 -0500
Received: from [195.180.174.223] ([195.180.174.223]:6784 "EHLO idun.neukum.org") by vger.kernel.org with ESMTP id <S132111AbRC1SOW>; Wed, 28 Mar 2001 13:14:22 -0500
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: jesse@cats-chateau.net
Subject: Re: Larger dev_t
Date: Wed, 28 Mar 2001 20:13:00 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset="US-ASCII"
References: <E14i0u8-0004N1-00@the-village.bc.nu> <m2snjyk0il.fsf@euler.axel.nom> <01032806025400.11349@tabby>
In-Reply-To: <01032806025400.11349@tabby>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01032820130006.01508@idun>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My suggestion would be to add a filesystem label (optional) to the
> homeblock of all filesystmes, then load that identifier into the
> /proc/partitions file. This would allow a search to locate the
> device parameters for any filesystem being mounted. If the label
> is unavailable, then it must be mounted manually or via the current
> structure. This would work for floppy/CD/DVD (although SCSI versions
> would have a relocation problem for these devices).

And what would you do if the names collide ?
This might work for drives with unique identifiers in hardware, but for 
anything else it is a nice addition, but I wouldn't identify an essential 
partition that way. Furthermore you need to address removable media. There a 
way to specify a drive opposed to a filesystem or medium is needed.

	Regards
		Oliver

