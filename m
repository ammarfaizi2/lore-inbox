Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292955AbSBVTQW>; Fri, 22 Feb 2002 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292956AbSBVTQN>; Fri, 22 Feb 2002 14:16:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28179
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292955AbSBVTQA>; Fri, 22 Feb 2002 14:16:00 -0500
Date: Fri, 22 Feb 2002 11:03:48 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <3C76279A.24763.17665F@localhost>
Message-ID: <Pine.LNX.4.10.10202221059340.32372-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Pedro M. Rodrigues wrote:

> 
>    I checked Microsoft's proposal recently. Didn't see see anything 
> devastating, could you please enlighten me on this one?

Does forcing a command to bypass the contents in the cache meaning
anything.  This is not a cache sync like SCSI.  It is a cache bypass and
will violate the journal on the down/commit block.


> 
> Thanks,
> Pedro
> 
> On 22 Feb 2002 at 1:25, Andre Hedrick wrote:
> 
> > continue to lobby for modification the Microsoft Proposal of a new
> > command, Force Unit Access, as make the Journaling File Systems
> > stable. Especially since their proposal and usage of the command under
> > EXT3/Reiser/XFS/etc would damage the data.
> 
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

