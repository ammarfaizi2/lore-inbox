Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265046AbRFZWAV>; Tue, 26 Jun 2001 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbRFZWAL>; Tue, 26 Jun 2001 18:00:11 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:35291 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S265046AbRFZV74>; Tue, 26 Jun 2001 17:59:56 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880ACB@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'Robert Love'" <rml@tech9.net>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: failed kernel 2.4.2 build after applying the patch ac28
Date: Tue, 26 Jun 2001 15:59:53 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 26 Jun 2001 15:35:09 -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:
>> I tried to build the 2.4.2 kernel after applying patch ac28
>> (patch-2.4.2-ac28) and it failed :-((
>> 
>> When it failed it gave the following message :
>> 
>> *** Install db development libraries
>> 
>> I thought kernel build should be independent of any userland libraries.


>i think this is because aicasm (the assembler for the aha7xxx scsi
>firmware) uses db1 to build itself.  are you compiling aha7xxx support
>into the kernel?

Yes, I am trying to compile aic7xxx support into the kernel.

>upgrade to the newest kernel (2.4.5-ac18) and rebuilding the firmware is
>optional, so you won't need the berekely db libraries.

Do you know from where can I get the berkeley db libraries ? Currently I do 
not want to upgrade my kernel. If you can suggest some changes to makefiles/
config files which will skip the steps to build the firmware, that would
also be great.

TIA
-hiren
