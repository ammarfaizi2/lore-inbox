Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSDIV5p>; Tue, 9 Apr 2002 17:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDIV5o>; Tue, 9 Apr 2002 17:57:44 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:5534 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S311829AbSDIV5o>; Tue, 9 Apr 2002 17:57:44 -0400
Date: Tue, 9 Apr 2002 15:16:01 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: John Jasen <jjasen1@umbc.edu>
Cc: Daniel Gryniewicz <dang@fprintf.net>, Andrew Burgess <aab@cichlid.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Tyan S2462 reboot problems
Message-ID: <20020409151601.A11100@vger.timpanogas.org>
In-Reply-To: <20020409161412.777aec9a.dang@fprintf.net> <Pine.SGI.4.31L.02.0204091619260.8816091-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have also seen some problems with the Tyan S2720 with hyperthreading 
enabled in a dual P4 configuration during bootup.  Several of the 
drivers lock up during bootup, AIC7XXX gets scsi timeouts and 
3Ware cards hard hang the bus when hyperthreading is enabled.  These 
problems do not occur on the SuperMicro P4DE6 which is also running 
the Intel 7500 chipset. 

Jeff


On Tue, Apr 09, 2002 at 04:20:17PM -0400, John Jasen wrote:
> On Tue, 9 Apr 2002, Daniel Gryniewicz wrote:
> 
> > No, I doubt this has anything to do with Linux.   I have a S2460 (which his
> > corrected post says he has), which does not power down under linux, and
> > *never* warm boots cleanly.  It does power down under windows, so I assume
> > ACPI powerdown works and APM does not.  I have gone under the assumption that
> > a BIOS upgrade will fix this, but that involves putting a floppy into the box,
> > so I haven't done it yet.  The warm boot problems consist of either a hang
> > after POST (but before bootloader, OS irrelevent), or really bad video
> > corruption.  I don't know if it boot with the video corruption, I've never let
> > it try.
> 
> I did update to the new BIOS for the 246x (I can never keep them straight
> either), and that did help some with the halt and reboot problems I was
> having.
> 
> 
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- User Error #2361: Please insert coffee and try again.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
