Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278960AbRJ2Cpw>; Sun, 28 Oct 2001 21:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278961AbRJ2Cpn>; Sun, 28 Oct 2001 21:45:43 -0500
Received: from cs.columbia.edu ([128.59.16.20]:60096 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S278960AbRJ2CpZ>;
	Sun, 28 Oct 2001 21:45:25 -0500
Date: Sun, 28 Oct 2001 21:45:52 -0500 (EST)
From: Shaya Potter <spotter@cs.columbia.edu>
X-X-Sender: <spotter@tripoli.clic.cs.columbia.edu>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IBM T-23 crashes on resume from suspend, 2.4.12-ac5
In-Reply-To: <34228322.1004315393@[195.224.237.69]>
Message-ID: <Pine.LNX.4.33.0110282141540.19825-100000@tripoli.clic.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had this problem with my T21 running xircom_tulip_cb (but not w/ 
xircom_cb) for a while (now everything works fine).  The way I got around 
it for a while, was rmmod'ing the module b4 I went to suspend

shaya

On Mon, 29 Oct 2001, Alex Bligh - linux-kernel wrote:

> When I suspend (apm -s, or system driven suspend), it appears to
> work. When I resume, the screen comes back, but the system
> appears to be dead to the extent that interrupts are disabled
> (i.e. caps lock key has no effect, SysReq+anything does nothing).
> 
> Although I'm running X, I'm doing this bit from a normal virtual
> console to make things simple.
> 
> I have tried various configuration options, including enabling
> and disabling ACPI, Plug & Play, and setting APM to call the
> BIOS with interrupts either enabled (seems to be recommended
> for 'later IBM laptops' or disabled). And indeed disabling
> APM support totally (I think I got it to work, once, using
> this, but couldn't repeat it).
> 
> Any ideas?
> 
> .config file (one iteration thereof) can be found at:
>   http://www.alex.org.uk/T23/dot-config-2.4.12-ac5
> 
> lspci output can be found at:
>   http://www.alex.org.uk/T23/lspci.txt
> 
> --
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

