Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287347AbSAHQy4>; Tue, 8 Jan 2002 11:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288166AbSAHQyq>; Tue, 8 Jan 2002 11:54:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41233 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287347AbSAHQyf>; Tue, 8 Jan 2002 11:54:35 -0500
Message-ID: <3C3B21AD.6080600@evision-ventures.com>
Date: Tue, 08 Jan 2002 17:43:25 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
CC: linux-kernel@vger.kernel.org, "White, Charles" <Charles.White@COMPAQ.com>
Subject: Re: PATCH 2.5.2-pre9 scsi cleanup
In-Reply-To: <45B36A38D959B44CB032DA427A6E1064012812AD@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cameron, Steve wrote:

>Martin Dalecki (dalecki@evision-ventures.com) wrote:
>
>[...]
>
>>--- linux-old/drivers/scsi/scsi.c	Sat May  4 09:11:44 2002
>>+++ linux/drivers/scsi/scsi.c	Sat May  4 07:49:19 2002
>>@@ -139,25 +139,7 @@
>>  */
>> unsigned int scsi_logging_level;
>> 
>>-const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] =
>>-{
>>-	"Direct-Access    ",
>>-	"Sequential-Access",
>>-	"Printer          ",
>>-	"Processor        ",
>>-	"WORM             ",
>>-	"CD-ROM           ",
>>-	"Scanner          ",
>>
>[...etc...]
>
>Hmmm, I was using that.... (In, for example, 
>the cciss patch here: http://www.geocities.com/smcameron 
>It's not any big deal, though.)
>
Precisely this "not any big deal" is the point: It was the wrong 
approach to a
trivial problem ;-).

