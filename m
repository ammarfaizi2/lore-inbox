Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbTAPVjL>; Thu, 16 Jan 2003 16:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAPVjK>; Thu, 16 Jan 2003 16:39:10 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:56264 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S267284AbTAPVjJ> convert rfc822-to-8bit; Thu, 16 Jan 2003 16:39:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: hda has changed heads [solved]
Date: Thu, 16 Jan 2003 22:49:13 +0100
User-Agent: KMail/1.4.3
References: <200301112249.11624.dreher@math.tu-freiberg.de> <200301162151.34206.dreher@math.tu-freiberg.de> <20030116212109.GB22359@win.tue.nl>
In-Reply-To: <20030116212109.GB22359@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301162249.13124.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. Januar 2003 22:21 schrieb Andries Brouwer:
> On Thu, Jan 16, 2003 at 09:51:34PM +0100, Michael Dreher wrote:

> > My solution is: reboot into 2.5.50. run lilo there. reboot into
> > 2.5.58. 
> >
> > This is annoying. Any ideas how to solve this ?
>
> You have not revealed your lilo version.

The old version was 22.1. Now I have upgraded to 22.3.2, and it works:

karpfen:/home/dreher # lilo
Warning: Kernel & BIOS return differing head/sector geometries for device 
0x80
    Kernel: 14120 cylinders, 16 heads, 63 sectors
      BIOS: 1024 cylinders, 255 heads, 63 sectors
Added testing *
Added linux
Added failsafe
Added linux-2.5.56
Added linux-2.5.50
Added windows

Very good. Thank you very much for your quick help.

Michael

