Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbRFUTMu>; Thu, 21 Jun 2001 15:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbRFUTMl>; Thu, 21 Jun 2001 15:12:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52416 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265128AbRFUTM2>;
	Thu, 21 Jun 2001 15:12:28 -0400
Date: Thu, 21 Jun 2001 15:12:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: abc abc <netlogin_99@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: rename problem on vfat file systems
In-Reply-To: <20010621190434.82955.qmail@web9604.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0106211510400.209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001, abc abc wrote:

> If I reboot the machine just after the rename() call
> is completed, when the machine comes up the file
> /mnt/sns-c/segments/segfile has zero bytes and there
> is no file in the tmp directory. Effectively the file
> is lost some where. Running fsck recovers the file,
> but it doesn't help me much because I would be copying
> hundreds of files and its difficult to match the
> files.
> 
> Can you think of any thing that might be causing this.

Crappy filesystem layout. If you want to do something a-la journalling
for VFAT - seek professional help.

