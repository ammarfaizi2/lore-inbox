Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSF0N5H>; Thu, 27 Jun 2002 09:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSF0N5G>; Thu, 27 Jun 2002 09:57:06 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:63954 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316851AbSF0N5G>; Thu, 27 Jun 2002 09:57:06 -0400
Date: Thu, 27 Jun 2002 15:26:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "John O'Donnell" <johnnyo@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo incomplete for AMD 386DX 40?
In-Reply-To: <3D1AE39A.9000200@mindspring.com>
Message-ID: <Pine.LNX.4.44.0206271521150.10717-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002, John O'Donnell wrote:

> This is an AMD 386 40Mhz with a 387 co-processor add-on and 32MB RAM.

ahhh =), i have a 386/40 w/ 4M RAM which erm does my bidding.

Here is what mine looks like;

processor       : 0
vendor_id       : unknown
cpu family      : 3
model           : 0
model name      : 386
stepping        : unknown
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : -1
wp              : no
flags           :
bogomips        : 7.93

> Is there any harm in Linux not identifying stuff like the manufacturer.
> I dont know if the i386 supports any extensions that would show up in
> the flags field.  Think the bogomips is right?!?

The flags field is stuff deduced from doing cpuid calls, so nothing there. 
The vendor might be a little difficult and might require depending on 
quirks of specific cpu models (i'm not 100% sure) therefore it would be a 
waste of memory to do.

> I have not met a box Linux hasn't liked yet :-)
> BTW it took half a day to compile 2.4.18 but It chugged away without a hitch!
> Linux juanisan 2.4.18 #1 Wed Jun 12 19:29:12 EDT 2002 i386 unknown

My you're patient, i build mine locally and netboot, 4M of RAM (no 
harddisk for swap) is too little to even attempt a kernel build i think.

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		

