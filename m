Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273667AbRIQTuD>; Mon, 17 Sep 2001 15:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbRIQTtx>; Mon, 17 Sep 2001 15:49:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49392
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273663AbRIQTts>; Mon, 17 Sep 2001 15:49:48 -0400
Date: Mon, 17 Sep 2001 12:50:06 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
Message-ID: <20010917125006.H24067@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA26542.21DC105A@MissionCriticalLinux.com> <3BA29CC2.8030008@phobos.sharif.edu> <3BA6517F.B0E18888@MissionCriticalLinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA6517F.B0E18888@MissionCriticalLinux.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 12:39:43PM -0700, Bruce Blinn wrote:
> Masoud Sharbiani wrote:
> > 
> > Hi,
> > Can you generate a cdrom image which has that problem (and less than 50
> > megs) in order
> > to test?
> > thanks,
> > Masoud
> 
> Hi Masoud:
> 
> I created a new CD that only contains linux-2.4.6.tar.gz (23Mb), and
> this CD duplicates my problem.  On 2.2.19, I can copy the tar file from
> the CD, and it is the same as the original, but when using 2.4.6, I get
> an IO error.
> 
> However, when I tried to copy the CD image to a file, I get the
> following IO error regardless of which kernel I use.
> 
> 	# dd if=/dev/cdrom of=/tmp/cd.iso
> 	dd: /dev/cdrom: Input/output error
> 	1440+0 records in
> 	1440+0 records out 
> 
> Does this shed any more light on what I am doing wrong.  Is there
> another way for me to create a CD image for you?
> 	
> Thanks,
> Bruce

Do you get any errors when you loopback mount the cd.iso file?
