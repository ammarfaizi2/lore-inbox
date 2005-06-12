Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVFLKPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVFLKPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVFLKPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:15:31 -0400
Received: from web30707.mail.mud.yahoo.com ([68.142.200.140]:8331 "HELO
	web30707.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261773AbVFLKPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:15:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TN/THJMQmadURnQhqynfclxxnvxI4mI3CYKLvalGvf/f049Wdvm+UDsKzoWMbYYXKIkDA13e8X09abfbP0ZRJ7gX6V3GYfHB2wvy2DKYWFR/KD5AwgpMEZE0aNFtlPmA5wiZi8le6kSKOT/vfBeLpZ+I9Z50mgPFSQtf9XJv7Yc=  ;
Message-ID: <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 03:15:14 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: optional delay after partition detection at boot time
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050612071213.GG28759@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,
 
 This is for a one-time use option, when the the admin
is having a hard time finding the root partition, let
alone the device NAME to boot the system ... proc is
not even mounted at that point yet.

 I can try booting ten times finding the correct scsi
device and partition number, but that's hairy
especially in situations where kernel config and BIOS
settings affect device detection.
 
 This is not for slowing everything down, let's say
just until root is mounted from then on, as you say,
dmesg and the system logs are available.

--- Willy Tarreau <willy@w.ods.org> wrote:

> On Sat, Jun 11, 2005 at 11:50:50PM -0700, subbie
> subbie wrote:
> > Hello,
> > 
> >  I'm sure some of you have come across this
> annoying
> > issue, the kernel messages scroll way too fast for
> a
> > human to be able to read them (let alone vgrep
> them).
> > 
> >  I'm proposing two features;
> > 
> >  1. a configurable (boot time, via kernel command
> > line) delay between each and every print -- kind
> of
> > overkill, but may be useful sometimes. 
> >  
> >  2. a configurable (boot time, via kernel command
> > line) delay after partition detection, so that a
> > humble system administrator would be able to
> actually
> > find out which partition he should specify at boot
> > time in order to boot his system.   This is
> especially
> > annoying on newer SATA systems where sometimes
> disks
> > are detected as SCSI and sometimes as standard ATA
> > (depending on BIOS settings), I'm sure though that
> it
> > could be useful in a number of other cases.
> 
> What's the problem with "cat /proc/partitions" or
> "dmesg" ?
> You seem to want to slow down *every* boot just to
> identify
> a partition you need to find *once*. This seems
> overkill.
> 
> willy
> 
> 



		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 

