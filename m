Return-Path: <linux-kernel-owner+w=401wt.eu-S1762253AbWLJQar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762253AbWLJQar (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762254AbWLJQar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:30:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:34836 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762253AbWLJQaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:30:46 -0500
Message-ID: <457C3635.5030509@argo.co.il>
Date: Sun, 10 Dec 2006 18:30:45 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan Chandler <alan@chandlerfamily.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE support on Intel DG965SS
References: <200612101558.34005.alan@chandlerfamily.org.uk>
In-Reply-To: <200612101558.34005.alan@chandlerfamily.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler wrote:
> I have been trying to find out if the kernel supports the IDE channel 
> (with a DVD/CD-R unit attached) on my Intel DG965SS motherboard.
>
> Searching the web indicates that for some motherboards based in the 
> Intel 965 chipset success has been had for 2.6.18 onward by using the 
> kernel boot parameters 
>
> all-generic-ide pci=nommconf
>
> Although these were Fedora Core 6.  
>
> I normally run Debian Unstable - but I have built 2.6.19 and installed 
> that (using the Debian .config as the base config) - mainly because to 
> get graphics to work it needs 2.6.19 to recognise the ids for the 
> agpgart module.
>
> However, despite every thing else working - I can't get the IDE 
> controller to be recognised - whether or not I use the above kernel 
> boot parameters. I have been UNABLE to find what all-generic-ide does - 
> it doesn't seem to be documented anywhere, so I was just blindly 
> following someones instructions..
>
> lspci -v shows the following
>
> 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 
> (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
>   

I have the same board at home.  I use all-generic-ide (without pci=...)

Do you have CONFIG_IDE_GENERIC set?


-- 
error compiling committee.c: too many arguments to function

