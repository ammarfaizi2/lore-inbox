Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSHCFBX>; Sat, 3 Aug 2002 01:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSHCFBW>; Sat, 3 Aug 2002 01:01:22 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:33531 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317466AbSHCFBW>; Sat, 3 Aug 2002 01:01:22 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>,
       "Greg KH" <greg@kroah.com>
Subject: Re: installation of latest kernel on compaq notebook
Date: Sat, 3 Aug 2002 15:00:05 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020803041256.2352.qmail@webmail10.rediffmail.com>
In-Reply-To: <20020803041256.2352.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208031500.05358.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002 14:12, Enugala Venkata Ramana wrote:
> Hi Greg,
>   I tried to configure my kernel. But when ever i try with kerel
> 2.4.xx i always find the catc driver for the usb is not enabled. I
> cannot add that into my kernel at all.can u please let me know
> what needs to be done in this is situation and what is the kernal
> version from which it is been enabled.
The use of "enabled" is confusing me. You aren't describing
the problem very well.

Do you mean that you cannot select in when you are doing
a "make menuconfig" or "make xconfig"?

Or do you mean that you have selected it, but it isn't being
compiled?

Or do you mean that you have it compiled, but the kernel
won't boot (or you can't modprobe the module)?

Or do you mean that it boots and the kernel shows
the catc driver (in /proc/bus/usb/drivers) but the 
device isn't being claimed (as shown in /proc/bus/usb/devices).

Exactly what are you trying to do, and what is happening?

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
