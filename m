Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262872AbTDAVFK>; Tue, 1 Apr 2003 16:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTDAVFK>; Tue, 1 Apr 2003 16:05:10 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:46073 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S262872AbTDAVFH>; Tue, 1 Apr 2003 16:05:07 -0500
Date: Tue, 1 Apr 2003 13:00:35 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Abhishek Sharma <abhisheks@dpsl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise RAID controller card
In-Reply-To: <1049206008.19702.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304011255470.2026-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Apr 2003, Alan Cox wrote:

> On Wed, 2003-04-02 at 03:52, Abhishek Sharma wrote:
> > Can someone tell me if the RAID controller card from Promise SX6000 is
> > supported by RHL 7.3 with kernel 2.4.18 ???

I've had less than terribly good luck with the i2o pci driver on these 
things. the promise pti_st  driver does working fairly well. tweaking the 
bios and playing with firmware versions was pretty hit-or-miss with the 
sx6000. for consistencys sake we just went with the promise module accross 
all our sx6000 using machines.
 
> Some SX6000 setups work some don't. Promise also have their own driver
> for the card you can download (its all source format). The older
> supertrak100 also works but both of them seem rather slower than the
> 3ware cards
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


