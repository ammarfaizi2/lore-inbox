Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262064AbREQRLE>; Thu, 17 May 2001 13:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbREQRKy>; Thu, 17 May 2001 13:10:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40748 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262064AbREQRKh>; Thu, 17 May 2001 13:10:37 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Nicolas Pitre <nico@cam.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home> <01051602593001.00406@starship>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 May 2001 11:07:46 -0600
In-Reply-To: Daniel Phillips's message of "Wed, 16 May 2001 02:59:30 +0200"
Message-ID: <m1u22jj44d.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> > Personally, I'd really like to see /dev/ttyS0 be the first detected
> > serial port on a system, /dev/ttyS1 the second, etc.
> 
> There are well-defined rules for the first four on PC's.  The ttySx 
> better match the labels the OEM put on the box.

Actually it would be better to have the OEM put a label in the
firmware, and then have a way to query the device for it's label.

The legacy rules are nice but serial ports are done with superio chips
now.  And superio chips are almost all ISA PNP chips without device
enumeration, and isolation. 

Eric

