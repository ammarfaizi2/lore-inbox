Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135329AbRA2KUm>; Mon, 29 Jan 2001 05:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbRA2KUb>; Mon, 29 Jan 2001 05:20:31 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:53517 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S135329AbRA2KUN>;
	Mon, 29 Jan 2001 05:20:13 -0500
Date: Mon, 29 Jan 2001 02:20:38 -0800
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: Re:  More on the VIA KT133 chipset misbehaving in Linux
Message-ID: <20010129022038.A22879@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <200101290920.BAA28321@mail15.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101290920.BAA28321@mail15.bigmailbox.com>; from "Quim K Holland" on Monday, 29 January 2001, at 01:20:15 (-0800)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 29 January 2001, at 01:20:15 (-0800),
Quim K Holland wrote:

>> "DG" == Dylan Griffiths <Dylan_G@bigfoot.com> writes:
>> 
> DG> The VIA KT133 chipset exhibits the following bugs under Linux
> DG> 2.2.17 and 2.4.0:
> DG> 1) PS/2 mouse cursor randomly jumps to upper right hand corner
> DG> of screen and locks for a bit
> DG> 2) Detects a maximum of 64mb of ram, unless worked around by the
> DG> "mem=" switch
> DG> 3) The clock drifts slowly (more so under heavy load than light
> DG> load), leaking time.
> 
> I am not a guru, but AOpen AK73PRO which uses VIA KT133 does not
> show any of these symptoms that you describe (I cannot be sure
> about #3 since I run ntp).  You may want to make your hardware
> description a bit more specific to help gurus to help you...
> 

I experience #2 and #3 on the following board w/ VIA KT133:

BIOS Vendor: American Megatrends Inc.
BIOS Version: 62710
BIOS Release: 07/15/97
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: 7ZX.
Board Version: 1.0.

ntpdate is run at boot..  

2:14am  up 14:59,  3 users,  load average: 0.00, 0.00, 0.00

And i just ran it again after running uptime, it showed the following:

29 Jan 02:15:20 ntpdate[3879]: step time server 164.67.62.194 offset 11.398730 sec

This is 2.4.1per11 btw.

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
