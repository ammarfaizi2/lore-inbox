Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283055AbRLJHFT>; Mon, 10 Dec 2001 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283467AbRLJHFJ>; Mon, 10 Dec 2001 02:05:09 -0500
Received: from david.siemens.de ([192.35.17.14]:7863 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S283055AbRLJHFG>;
	Mon, 10 Dec 2001 02:05:06 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5]  /ALSA-0.9.0beta[9,10]
Date: Mon, 10 Dec 2001 10:04:55 +0300
Message-ID: <000701c18148$f907f040$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There are some broken boot scripts (modelled after the long obsolete 
>> rc.devfs script) 
>
>
> Which is still included in the kernel tree and at least Mandrake is 
> currently using it. 

Which resulted in weird problems like floating device numbers, broken
links in /dev/cdroms, mysteriously disappearing sound nodes ... 

I very much appreciate this decision. Copying over device nodes is evil.
It should be stopped by all means (as long as devfs is going to be
used).

-andrej
