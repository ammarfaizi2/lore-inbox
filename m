Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268407AbTCCH3G>; Mon, 3 Mar 2003 02:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268414AbTCCH3G>; Mon, 3 Mar 2003 02:29:06 -0500
Received: from [196.12.44.6] ([196.12.44.6]:52440 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S268407AbTCCH3F>;
	Mon, 3 Mar 2003 02:29:05 -0500
Date: Mon, 3 Mar 2003 13:09:29 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
In-Reply-To: <96100000.1046676676@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0303031307570.30529-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the output stopped after it printed the line "Freeing unused kernel 
memory".  How do we manage to get the printk's to the serial line after 
this. I can see the messages using 'dmesg' but am not getting them over 
the serial line.

Prasad.

On Sun, 2 Mar 2003, Martin J. Bligh wrote:

> 
> 
> --On Monday, March 03, 2003 12:58:24 +0530 Prasad <prasad_s@students.iiit.net> wrote:
> 
> > 
> > 
> > I have seen the Documentation/serial-console.txt and accordingly gave the 
> > kernel arguments console=/dev/ttyS0,9600n8, but even after giving that i 
> > am not getting anything to the other end. To check if the serial 
> > communication was in place... i tried echo "abc" > /dev/ttyS0 and that 
> > worked.
> 
> I use "console=ttyS0,57600n8" - no "/dev".
> 
> M.
> 

-- 
Failure is not an option

