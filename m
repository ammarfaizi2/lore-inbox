Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSBCWSK>; Sun, 3 Feb 2002 17:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSBCWSA>; Sun, 3 Feb 2002 17:18:00 -0500
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:42680 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287816AbSBCWRv>; Sun, 3 Feb 2002 17:17:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Date: Sun, 3 Feb 2002 17:18:57 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <m1y9ia76f7.fsf@frodo.biederman.org> <3C5D91EB.4000900@zytor.com>
In-Reply-To: <3C5D91EB.4000900@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020203221750.HMXG18301.femail20.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 February 2002 02:39 pm, H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> > The simplest is the observation that right now 10MB is about what it
> > takes to hold every Linux driver out there.  So all you really need is
> > a 16MB system, to avoid a device probing loader.  And probably
> > noticeably less than that.  The only systems I see having real
> > problems are old systems where device enumeration is not reliable, and
> > require human intervention anyway.
>
> A floppy disk is 1.44 MB.

And el-torito bootable CDs basically glue a floppy image onto the front of 
the CD and lie to the bios to say "oh yeah, I'm a floppy, boot from me".  
Luckily, they can use the old 2.88 "extended density" floppy standard IBM 
tried to launch years ago which never got anywhere, but which most BIOS's 
recognize.  But that's still a fairly small place to try to stick a whole 
system...

> 	-hpa

Rob
