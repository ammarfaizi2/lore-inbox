Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRATRO7>; Sat, 20 Jan 2001 12:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRATROs>; Sat, 20 Jan 2001 12:14:48 -0500
Received: from mserv1e.vianw.co.uk ([195.102.240.97]:2766 "EHLO
	mserv1e.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S129413AbRATROm>; Sat, 20 Jan 2001 12:14:42 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Date: Sat, 20 Jan 2001 17:14:04 +0000
Organization: [private individual]
Message-ID: <ejgj6tg2l03r18grn4shgtjmsp5cip6qc9@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on Fri Jan 19 2001 - 10:56:10 EST Vojtech Pavlik (vojtech@suse.cz)
wrote
> ...
>I'm sending you (and others who might be interested) my latest VIA and 
>IDE drivers. The VIA driver (v3.15) should have a complete support for 
>UDMA100 on the vt82c686b chip, the AMD driver (v1.5) should have full 
>UDMA100 support on the amd766 ViperPlus chip. 
>
>
>They're also a little more foolproof with respect to the 'idebus' 
>setting, which is quite a misnomer, btw. 
>
>
>Care to try them out? 

If by "trying them out" you mean dropping them in the drivers/ide
subdirectory of the 2.4.0 source and rebuilding the kernel, then they
still cause my machine to give CRC errors.

I'm running with an Abit K7 (uses via82c686a in southbridge) with IBM
deskstar 8.4gb disks (DHEA-38451) as masters in ide0 and 1. They only
do UDMA mode 2. I am not overclocking or anything - all should be
running at default speeds with an Athlon 900.  

Just to be clear - I am NOT getting any errors when I switch back to
the 2.2.17 kernel (debian standard) - with a 2.4.0 kernel they occur
every few minutes when there is significant disk activity. 



Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
