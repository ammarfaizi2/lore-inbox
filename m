Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLTBG3>; Tue, 19 Dec 2000 20:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbQLTBGK>; Tue, 19 Dec 2000 20:06:10 -0500
Received: from feral.com ([192.67.166.1]:849 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S129324AbQLTBGC>;
	Tue, 19 Dec 2000 20:06:02 -0500
Date: Tue, 19 Dec 2000 16:35:29 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jesper Juhl <juhl@eisenstein.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Platform string wrong for AlphaServer 400 4/233
In-Reply-To: <20001219.15311300@jju.hyggekrogen.dk>
Message-ID: <Pine.LNX.4.21.0012191635020.7545-100000@zeppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Take it up with Compaq. The platform string value is that which is set in the
HWRPB constructed with SRM.


> 
> Hi,
> 
> This is a minor issue, but I thought I'd report it anyway.
> 
> When I do a 
> 
> # cat /proc/cpuinfo
> 
> on my AlphaServer 400 4/233 I get the following (IMHO wrong) output:
> 
> cpu                     : Alpha
> cpu model               : EV45
> cpu variation           : 7
> cpu revision            : 0
> cpu serial number       :
> system type             : Avanti
> system variation        : 0
> system revision         : 0
> system serial number    :
> cycle frequency [Hz]    : 233334892 est.
> timer frequency [Hz]    : 1024.00
> page size [bytes]       : 8192
> phys. address bits      : 34
> max. addr. space #      : 63
> BogoMIPS                : 229.11
> kernel unaligned acc    : 0 (pc=0,va=0)
> user unaligned acc      : 0 (pc=0,va=0)
> platform string         : AlphaStation 400 4/233
> cpus detected           : 1                                               
>                     
> 
> 
> The problem is that the 'Platform string' is set to 'AlphaStation 400 
> 4/233' when this machine is quite clearly (it's printed on it) a 
> 'AlphaServer 400 4/233' ( It is this machine: 
> http://www5.compaq.com/alphaserver/archive/400/alphaserver400.html ).
> 
> It's nothing important, and it runs Linux just fine. Just thought it 
> would be nice to see it fixed (if it is at all possible to tell the two 
> different systems apart from the kernels point of view).
> 
> 
> Best regards,
> Jesper Juhl
> juhl@eisenstein.dk
> 
> 
> PS. Please CC all replies to me as I am not subscribed to the list.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
