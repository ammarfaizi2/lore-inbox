Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKVLBV>; Thu, 22 Nov 2001 06:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKVLBL>; Thu, 22 Nov 2001 06:01:11 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:38872 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S277228AbRKVLA4>; Thu, 22 Nov 2001 06:00:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 11:00:54 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166rbB-0005LC-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 1:53 am, war wrote:
> I do not understand something.
>
> How can having swap speed ANYTHING up?

By providing ADDITIONAL storage. Yes, it's slower than RAM - but it's faster 
than not having the storage at all.

> RAM = 1000MB/s.
> DISK = 10MB/s
>
> Ram is generally 1000x faster than a hard disk.
>
> No swap = fastest possible solution.

BS. You don't use swap INSTEAD of RAM, but AS WELL AS. Moving less frequently 
used data to swap allows you to put more frequently used data in RAM, which 
DOES speed things up. (At least, it does if the VM system works properly :P)

By your logic, we should switch off the system RAM, too: after all, L2 cache 
is much faster again, so using RAM can only slow things down?


James.
