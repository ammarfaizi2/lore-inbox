Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSJPR3Y>; Wed, 16 Oct 2002 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJPR3X>; Wed, 16 Oct 2002 13:29:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261173AbSJPR3U>; Wed, 16 Oct 2002 13:29:20 -0400
Date: Wed, 16 Oct 2002 13:35:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Cuss <mcuss@cdlsystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <077901c27538$ef71b4a0$2c0e10ac@frinkiac7>
Message-ID: <Pine.LNX.3.95.1021016133227.139A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Mark Cuss wrote:

> Hello all
> 
> I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.  However,
> Linux reports that it sees 4 CPUs...  I have opened the thing to see if Dell
> gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.
> 
> I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled 2.4.19
> but both exhibit the same behavior.
> 
> The specifics on the machine:
> 
> Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
> 2 Gigs DDR RAM
> The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
> listing).
> 
> Has anyone else seen this behavior?  The only other SMP machine I have is an
> older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...
> 
> Any information or advice is greatly appreciated...
> 
> Thanks in Advance,
> 
> Mark
> 

This has become a FAQ. The processors are capable of so-called
"hyperthreading". They have two execution units, therefore seem
like two CPUs.

This is the correct behavior. If you don't like this, you can
swap motherboards with me ;) Otherwise, grin and bear it!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

