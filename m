Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbRG3Vih>; Mon, 30 Jul 2001 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268320AbRG3ViR>; Mon, 30 Jul 2001 17:38:17 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:44538 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S268304AbRG3ViF>;
	Mon, 30 Jul 2001 17:38:05 -0400
Message-ID: <3B65D3DA.D70B48A0@fc.hp.com>
Date: Mon, 30 Jul 2001 15:38:34 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302126.f6ULQPi1032424@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andreas Dilger wrote:
> 
> Khalid Aziz writes:
> > I am working on adding support for serial console on legacy free
> > machines. Legacy free machines are not expected to have the legacy COM
> > ports.
> 
> Has anyone considered allowing console devices to run over bi-directional
> parallel ports?  I imagine most of the required code is in PLIP and serial,
> which unfortunately I know nothing about.
> 
> Several newer systems I have today do not have physical serial ports at all,
> but all of them (even laptops) still have bi-directional parallel ports.
> 
> I suppose there may be some difficulties in exporting a "serial-like"
> interface to the user apps (e.g. minicom and such), but maybe not.
> 

SH supports console on line printer which I assume is a parallel port
console. You can check if that code will work for you and if it can be
ported to x86.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
