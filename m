Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRJNBPi>; Sat, 13 Oct 2001 21:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJNBPQ>; Sat, 13 Oct 2001 21:15:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60165 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S272980AbRJNBPM>;
	Sat, 13 Oct 2001 21:15:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck 
In-Reply-To: Your message of "Sat, 13 Oct 2001 14:09:32 EST."
             <Pine.LNX.4.30.0110131407220.6512-100000@waste.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Oct 2001 11:15:15 +1000
Message-ID: <26333.1003022115@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 14:09:32 -0500 (CDT), 
Oliver Xymoron <oxymoron@waste.org> wrote:
>Is this your root partition perhaps? Fsck of a mounted device might act a
>little differently with the new blockdev-in-pagecache approach.

It is root.  The problem exists on 2.4.9 kernels as well as
2.4.13-pre1.  The 2.4.9 kernels are RH 7.2 IA64 beta so they might
contain code from the -ac tree.

