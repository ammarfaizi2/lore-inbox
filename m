Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTLMD0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTLMD0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:26:15 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:31168 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263125AbTLMD0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:26:12 -0500
Message-ID: <20031213032610.11839.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "surya prabhakar" <surya_prabhakar@linuxmail.org>
To: "Stefan Smietanowski" <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 13 Dec 2003 08:26:10 +0500
Subject: Re: Intel 82801EB chipset issue
X-Originating-Ip: 203.200.54.66
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
   thx for the suggestion .  The problem is I have some tools which are only supported by vendors on redhat 7.3 ( i mean with this kernel 2.4.18-3) . I cant change the kernel . So I am looking for a patch I mean add some support for 82801EB in piix.c or pci-irq.c , something like that . I have found some patches in kernelnewbies.org but they all cater to 2.4.20 , the structure of the kernel in drivers/ide is different . Further u go up to 2.4.21EL kernel there is no piix.c , it is replaced by ata_piix.c , I am not able to patch it .Further I have to make it working on 2.4.18-27.7.x also ( that is redhat upgraded kernel ) .



----- Original Message -----
From: Stefan Smietanowski <stesmi@stesmi.com>
Date: 	Sat, 13 Dec 2003 04:03:53 +0100
To: surya prabhakar <surya_prabhakar@linuxmail.org>
Subject: Re: Intel 82801EB chipset issue

> surya prabhakar wrote:
> 
> > Dear All ,
> >     I have an IBM Mpro with Intel 875p motherboard with SATA (ICH5 ) 82801EB chip on it . THe problem is this chipset is not recognised in redhat 7.3 , does not get installed ,it cannot find the neither harddrive or cdrom drives ( IDE only not SATA ) . I need it working on redhat 7.3 (2.4.18-3) . Any suggestive patch /work-around will be highly appreciated .
> > 
> > Thanks and regards
> > 
> > Surya Prabhakar N ,
> > Technical Specialist ,
> > Strategy & Deployment Team ,
> > Wipro Limited ,
> > Bangalore - India.
> > 
> 
> You have a few options:
> 
> 1) Install on another drive, get latest kernel.org kernel, add
> libata support to it. Recompile it, install it, run it.
> Copy system to SATA drive. Use it.
> 
> 2) Install on another drive, get latest Fedora Core 1 kernel,
> recompile it after disabling ntpl support in it. Install and run
> kernel.Copy system to SATA drive. Use it.
> 
> 3) Install something else (For instance Fedora Core 1) that has
> native support for that controller.
> 
> "Another drive" means "another machine" btw. One that is supported.
> 
> // Stefan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



Surya Prabhakar N ,
Technical Specialist ,
Strategy & Deployment Team ,
Wipro Limited ,
Bangalore - India.

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
