Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSDPKLD>; Tue, 16 Apr 2002 06:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDPKLC>; Tue, 16 Apr 2002 06:11:02 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:3038 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S292857AbSDPKLC>; Tue, 16 Apr 2002 06:11:02 -0400
Date: Tue, 16 Apr 2002 12:01:48 +0200
From: Olaf Fraczyk <olaf@navi.pl>
To: Liam Girdwood <l_girdwood@bitwise.co.uk>
Cc: BALBIR SINGH <balbir.singh@wipro.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416100148.GA17560@venus.local.navi.pl>
In-Reply-To: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com> <1018952961.31914.446.camel@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.04.16 12:29 Liam Girdwood wrote:
> On Tue, 2002-04-16 at 09:18, BALBIR SINGH wrote:
> > I remember seeing somewhere unix system VII used to have HZ set to
> 60
> > for the machines built in the 70's. I wonder if todays pentium iiis
> and ivs
> > should still use HZ of 100, though their internal clock is in GHz.
> >
> > I think somethings in the kernel may be tuned for the value of HZ,
> these
> > things would be arch specific.
> >
> > Increasing the HZ on your system should change the scheduling
> behaviour,
> > it could lead to more aggresive scheduling and could affect the
> > behaviour of the VM subsystem if scheduling happens more frequently.
> I am
> > just guessing, I do not know.
> >
> 
> I remember reading that a higher HZ value will make your machine more
> responsive, but will also mean that each running process will have a
> smaller CPU time slice and that the kernel will spend more CPU time
> scheduling at the expense of processes.
> 
Has anyone measured this?
This shouldn't be a big problem, because some architectures use value 
1024, eg. Alpha, ia-64.
And todays Intel/AMD 32-bit processors are as fast as Alpha was 1-2 
years ago.

Regards,

Olaf


