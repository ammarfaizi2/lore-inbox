Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbUDTQIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUDTQIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUDTQIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:08:13 -0400
Received: from web12305.mail.yahoo.com ([216.136.173.103]:63305 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263137AbUDTQII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:08:08 -0400
Message-ID: <20040420160806.33161.qmail@web12305.mail.yahoo.com>
Date: Tue, 20 Apr 2004 09:08:06 -0700 (PDT)
From: Mike Keehan <mike_keehan@yahoo.com>
Subject: Re: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
In-Reply-To: <20040420155903.GA16152@zarquon.at.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting these too in recent kernels, but only on a
10Mhz half-duplex network. I have to manually down
and up the interface to recover.

On a 100Mhz switched network, the e100 is OK (at least 12hours+).

Mike.

NETDEV WATCHDOG: eth0: transmit timed out
--- Mike@Keehan.net wrote:
> ----- Forwarded message from Eamonn Hamilton
> <EAMONN.HAMILTON@saic.com> -----
> 
> Subject: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
> From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
> To: linux-kernel@vger.kernel.org
> Date: Tue, 20 Apr 2004 10:13:33 +0100
> 
> Hi,
> 
> Since 2.6.4 my ethernet interface is timing out after successfully
> operating for 30 minutes or so, and is reset by the watchdog and runs
> for another 30 minutes or so. This behaviour is only since 2.6.4 when
> I
> believe a rewrite of the code was done. I've tried it with acpi
> disabled, and got the same results if this helps.
> 
> Anybody got any ideas?
> 
> Cheers,
> Eamonn
> -- 
> Eamonn Hamilton <hamiltonea@uk-aberdeen.mail.saic.com>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> ----- End forwarded message -----



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
