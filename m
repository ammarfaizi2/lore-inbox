Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRCZRnN>; Mon, 26 Mar 2001 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132513AbRCZRnD>; Mon, 26 Mar 2001 12:43:03 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:7952
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132514AbRCZRmr>; Mon, 26 Mar 2001 12:42:47 -0500
Date: Mon, 26 Mar 2001 09:41:43 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Uncle George <gatgul@voicenet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: slow latencies on IDE disk drives( controller? )
In-Reply-To: <3ABF2679.B1E50DD7@voicenet.com>
Message-ID: <Pine.LNX.4.10.10103260844310.12547-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello GAT,

Can you be more specific?  I need a kernel and hardware info and generally
more info than what is given.  Is this a PIO/DMA process is it a laptop or
unsupported hardware?

On Mon, 26 Mar 2001, Uncle George wrote:

> I am processing sound data on /dev/dsp. Generally the ~61k devive buffer
> is enough to keep the device satiated && gives the program time to fill
> up the device buffer when there is 16k of buffer space that needs to be
> filled.
> 
> But on occasion the /dev/dsp device "slurrs" ( sounds like what happens
> when the speed of a tape recorder slows down due to a finger placed down
> on the capstain ) unexpectedly. This was eventually traced to the usage
> of an IDE disk drive. using the scsi drive does not cause the problem to

How did you derive this path to the ATA driver?
What is the drive, and how fast (or how slow) is it?

> manifest itself( at least my ears say so ). but using "dd if=/dev/hda4
> of=/dev/null ) does immediately cause the slurring to happen.
> 
> 
> I think I can create a simple pgm to demo this problem, but the DATA
> file that gets feed into /dev/dsp is a little large for e-mail.

The content of the barf is not important, but the process you are doing to
create this issue is.

Andre Hedrick
Linux ATA Development

