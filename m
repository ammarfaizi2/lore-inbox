Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRHVKKt>; Wed, 22 Aug 2001 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRHVKKj>; Wed, 22 Aug 2001 06:10:39 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:34941 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S271981AbRHVKK3>; Wed, 22 Aug 2001 06:10:29 -0400
Date: Wed, 22 Aug 2001 12:10:27 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Backporting drivers from 2.4 to 2.2
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9D4@mail0.myrio.com>
Message-ID: <Pine.LNX.4.33.0108221209330.3668-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Torrey Hoffman wrote:

>
> Is there a document somewhere that has some hints and tips for
> backporting 2.4 drivers to the 2.2 series?  I have the O'Reilly
> Linux Device Drivers (second edition) book by Rubini and Corbet,
> but it's a little thin on this problem.
>
> Specifically, the new 2.4 PCI-related functions like:
> pci_alloc_consistent, pci_free_consistent, pci_enable_device...
>
> >From this newbie's point of view, it seems that it would be really
> nice to have a little library of functions that wrap the older 2.2
> style interface to provide the 2.4-style functions...  or is this
> impossible to do in a general way?

Have a look at:

http://gtf.org/garzik/drivers/kcompat24/


Rui Sousa

