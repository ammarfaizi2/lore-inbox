Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272370AbRIOPnD>; Sat, 15 Sep 2001 11:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272359AbRIOPmx>; Sat, 15 Sep 2001 11:42:53 -0400
Received: from hermes.domdv.de ([193.102.202.1]:54026 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272330AbRIOPmg>;
	Sat, 15 Sep 2001 11:42:36 -0400
Message-ID: <XFMail.20010915174233.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA375D0.6020903@redhat.com>
Date: Sat, 15 Sep 2001 17:42:33 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, linux-kernel@vger.kernel.org,
        Frank Schneider <\"\"SPATZ1\"@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15-Sep-2001 Doug Ledford wrote:
> Andreas Steinmetz wrote:
> 
>> Hi,
>> 2.2.19 only has the 'old' driver. The 'raid/scsi new' problem is a notifier
>> chain sequence problem that seems to have been taken care of now.
>> What I do see here may be a coincidence of kernel upgrade and a faulty
>> drive.
>> Some snippets of 2.2.19 log messages of a faulty drive below.
>> 
>> May  2 03:33:07 pollux kernel: (scsi1:0:1:0) Parity error during Data-In
>> phase.
>> May  2 03:33:37 pollux kernel: scsi : aborting command due to timeout : pid
>> 1188263, scsi1, channel 0, id 1, lun 0 Read (10) 00 01 04 cd 97 00 00 80 00 
> 
> 
> 
> I've seen that error a few times now with the new code in 2.2.19.  I 
> don't have a fix for it at this time (and I probably won't since 
> development on that driver isn't a 'regular' thing at this point).  If 
> the old driver in 2.2.18 worked for you, then I would copy the aic7xxx* 
> files from 2.2.18 into 2.2.19 and rebuild your kernel.
> 
> 
Please note that the disk was proven faulty. (Other kernel, other OS on other
hardware, disk still failing, since then replaced and no more problems).


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
