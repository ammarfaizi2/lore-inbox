Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268426AbTCCHlL>; Mon, 3 Mar 2003 02:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268427AbTCCHlK>; Mon, 3 Mar 2003 02:41:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39137 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268426AbTCCHlJ>; Mon, 3 Mar 2003 02:41:09 -0500
Date: Sun, 02 Mar 2003 23:51:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Prasad <prasad_s@students.iiit.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
Message-ID: <1070000.1046677885@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303031307570.30529-100000@students.iiit.net>
References: <Pine.LNX.4.44.0303031307570.30529-100000@students.iiit.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure there's no serial stuff, etc in your init scripts that
changes speeds or anything. Other than that, not sure ... been
so long since I set it up, I forget ...

M.

--On Monday, March 03, 2003 13:09:29 +0530 Prasad <prasad_s@students.iiit.net> wrote:

> 
> the output stopped after it printed the line "Freeing unused kernel 
> memory".  How do we manage to get the printk's to the serial line after 
> this. I can see the messages using 'dmesg' but am not getting them over 
> the serial line.
> 
> Prasad.
> 
> On Sun, 2 Mar 2003, Martin J. Bligh wrote:
> 
>> 
>> 
>> --On Monday, March 03, 2003 12:58:24 +0530 Prasad <prasad_s@students.iiit.net> wrote:
>> 
>> > 
>> > 
>> > I have seen the Documentation/serial-console.txt and accordingly gave the 
>> > kernel arguments console=/dev/ttyS0,9600n8, but even after giving that i 
>> > am not getting anything to the other end. To check if the serial 
>> > communication was in place... i tried echo "abc" > /dev/ttyS0 and that 
>> > worked.
>> 
>> I use "console=ttyS0,57600n8" - no "/dev".
>> 
>> M.
>> 
> 
> -- 
> Failure is not an option
> 
> 


