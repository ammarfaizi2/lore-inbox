Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSDTRpi>; Sat, 20 Apr 2002 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDTRoC>; Sat, 20 Apr 2002 13:44:02 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:7669 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S314672AbSDTRn0>; Sat, 20 Apr 2002 13:43:26 -0400
Message-ID: <3CC1A8BD.2899AB80@redhat.com>
Date: Sat, 20 Apr 2002 18:43:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Abbey <linux@cabbey.net>, linux-kernel@vger.kernel.org
Subject: Re: PDC20268 TX2 support?
In-Reply-To: <E16yqWt-0000QP-00@the-village.bc.nu> <Pine.LNX.4.33.0204201226530.25636-100000@tweedle.cabbey.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Abbey wrote:
> 
> Today, Alan Cox wrote:
> > > the 2.4.19 timeframe. I'm curious what level of support folks are
> > > expecting? Just basic IDE, or support for the hardware raid features?
> >
> > What hardware raid features ?
> 
> The FastTraK 100 TX2 has hardware raid (stripe/mirror) support, they
> have a binary only driver (scsi/ft.o) which presents this array as
> a scsi device... this is the level of function I was hoping was being
> integrated.

that is not hardware raid but software raid.

> 
> > AFAIK their only cards with hardware raid features are the supertrak 100 and
> > SX6000.
> 

> The current 2.4.18 code recognizes the card and provides vanilla IDE
> access to the drives, unfortunately that isn't much use unless someone
> wants to try and RE their block allocation on the disks... a decidedly
> non-trivial endeavour I can assure you. ;(

It seems you missed the ATARAID stuff in the ide config..
