Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbRIOPiC>; Sat, 15 Sep 2001 11:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272320AbRIOPhw>; Sat, 15 Sep 2001 11:37:52 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:62738 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272328AbRIOPhh>; Sat, 15 Sep 2001 11:37:37 -0400
Message-ID: <3BA375D0.6020903@redhat.com>
Date: Sat, 15 Sep 2001 11:37:52 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010905
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Frank Schneider <\"\"SPATZ1\"@t-online.de>, linux-kernel@vger.kernel.org,
        Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
In-Reply-To: <XFMail.20010914153738.ast@domdv.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:

> Hi,
> 2.2.19 only has the 'old' driver. The 'raid/scsi new' problem is a notifier
> chain sequence problem that seems to have been taken care of now.
> What I do see here may be a coincidence of kernel upgrade and a faulty drive.
> Some snippets of 2.2.19 log messages of a faulty drive below.
> 
> May  2 03:33:07 pollux kernel: (scsi1:0:1:0) Parity error during Data-In phase.
> May  2 03:33:37 pollux kernel: scsi : aborting command due to timeout : pid
> 1188263, scsi1, channel 0, id 1, lun 0 Read (10) 00 01 04 cd 97 00 00 80 00 



I've seen that error a few times now with the new code in 2.2.19.  I 
don't have a fix for it at this time (and I probably won't since 
development on that driver isn't a 'regular' thing at this point).  If 
the old driver in 2.2.18 worked for you, then I would copy the aic7xxx* 
files from 2.2.18 into 2.2.19 and rebuild your kernel.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

