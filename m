Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbREQTbK>; Thu, 17 May 2001 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbREQTbA>; Thu, 17 May 2001 15:31:00 -0400
Received: from gopostal.digi.com ([204.221.110.15]:44812 "EHLO
	gopostal.digi.com") by vger.kernel.org with ESMTP
	id <S261517AbREQTan>; Thu, 17 May 2001 15:30:43 -0400
From: Jeff Randall <randall@bif.digi.com>
Message-Id: <200105171930.OAA26119@bif.digi.com>
Subject: Re: LANANA: To Pending Device Number Registrants
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 17 May 2001 14:30:10 -0500 (CDT)
Cc: phillips@bonn-fries.net (Daniel Phillips), nico@cam.org (Nicolas Pitre),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <m1u22jj44d.fsf@frodo.biederman.org> from "Eric W. Biederman" at May 17, 2001 11:07:46 AM
Reply-To: Jeff_Randall@digi.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Daniel Phillips <phillips@bonn-fries.net> writes:
> > On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> > > Personally, I'd really like to see /dev/ttyS0 be the first detected
> > > serial port on a system, /dev/ttyS1 the second, etc.
> > 
> > There are well-defined rules for the first four on PC's.  The ttySx 
> > better match the labels the OEM put on the box.
> 
> Actually it would be better to have the OEM put a label in the
> firmware, and then have a way to query the device for it's label.
> 
> The legacy rules are nice but serial ports are done with superio chips
> now.  And superio chips are almost all ISA PNP chips without device
> enumeration, and isolation. 

Not all serial ports are superio chips.  There's all kinds of serial
ports on all kinds of different busses being supported under Linux.  The
company I work for supports serial ports on ISA, PCI, SCSI, Ethernet, and
USB at the moment...


-- 
Jeff Randall - Jeff_Randall@digi.com  "A paranoid person is never alone,
                                       he knows he's always the center
                                       of attention..."
