Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287976AbSAHQPx>; Tue, 8 Jan 2002 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288129AbSAHQPo>; Tue, 8 Jan 2002 11:15:44 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:56850 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S287976AbSAHQPf> convert rfc822-to-8bit; Tue, 8 Jan 2002 11:15:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: PATCH 2.5.2-pre9 scsi cleanup
Date: Tue, 8 Jan 2002 10:15:27 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E1064012812AD@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: PATCH 2.5.2-pre9 scsi cleanup
Thread-Index: AcGYX6+HHO0GeftCS7WdPYeRrBMMIg==
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: <linux-kernel@vger.kernel.org>
Cc: <dalecki@evision-ventures.com>,
        "White, Charles" <Charles.White@COMPAQ.com>
X-OriginalArrivalTime: 08 Jan 2002 16:15:28.0757 (UTC) FILETIME=[B0245250:01C1985F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki (dalecki@evision-ventures.com) wrote:

[...]
> --- linux-old/drivers/scsi/scsi.c	Sat May  4 09:11:44 2002
> +++ linux/drivers/scsi/scsi.c	Sat May  4 07:49:19 2002
> @@ -139,25 +139,7 @@
>   */
>  unsigned int scsi_logging_level;
>  
> -const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] =
> -{
> -	"Direct-Access    ",
> -	"Sequential-Access",
> -	"Printer          ",
> -	"Processor        ",
> -	"WORM             ",
> -	"CD-ROM           ",
> -	"Scanner          ",
[...etc...]

Hmmm, I was using that.... (In, for example, 
the cciss patch here: http://www.geocities.com/smcameron 
It's not any big deal, though.)

-- steve
