Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135767AbRAQV0f>; Wed, 17 Jan 2001 16:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135765AbRAQV0Y>; Wed, 17 Jan 2001 16:26:24 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:30458 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S135564AbRAQV0M>; Wed, 17 Jan 2001 16:26:12 -0500
Date: Wed, 17 Jan 2001 13:26:05 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <20010117202222.B4979@almesberger.net>
Message-ID: <Pine.LNX.4.21.0101171325080.30136-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Werner Almesberger wrote:
> "no", because you don't have to do it in the kernel. You can mount by
> uuid or label. For the root FS, you do this from an initrd. Problem
> solved.
> 
> The only cases when you really need to know the name of a disk is when
>  - doing disk-level management, e.g. partitioning or creating file
>    systems (*)
>  - adding a swap partition (sigh)
>  - telling your boot loader where to put its boot sector
> 
> (* in principle, you could even avoid this, if you have some means of
>    identifying a disk (e.g. via the uuid of a file system). However,
>    I would consider such a solution to be overly fragile.)

That's exactly my point...It doesn't need to be there; there are already
ways around it. They just need to be documented, that's all.

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
