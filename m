Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268881AbRG0QTs>; Fri, 27 Jul 2001 12:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268883AbRG0QTj>; Fri, 27 Jul 2001 12:19:39 -0400
Received: from [213.97.184.209] ([213.97.184.209]:22144 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S268884AbRG0QTX>;
	Fri, 27 Jul 2001 12:19:23 -0400
Date: Fri, 27 Jul 2001 18:19:17 +0200
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems with post 2.4.6-pre3aa2
Message-ID: <20010727181917.A550@hal9000.piraos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	Hello,

	I've running 2.4.6-pre3 patched with Andrea Arcangelli 2.4.6pre3aa2 
for more than two weeks with no problems. But newer kernels give me strange
problems. 

	I've tested with 2.4.6-pre6, 2.4.6, 2.4.7, 2.4.7-ac1 and all of them
give the same result. They run stable for about a day but suddenly with no
log
output the system hangs up, no screen output, nothing, just completely
hanged.
I have got exactly the same problem some time ago, and I found it was
related
to APM/ACPI, if I enabled APM in the BIOS and don't compile the APM support
into
the kernel (although it was not loaded as I'm using SMP) the system would go
deep sleep and wouldn't be able to wake up. After adding support for APM
into
the kernel the system worked again. But now I've tried every combination,
disabling
APM in the BIOS, enabling in the kernel, etc, with no success.

	It may be also related to the changes in the VM as I think it was
changed
during the 2.4.6-pre series.
	
	Any ideas?

	Regards,

	- german

PS: Please CC to me as I'm not subscribed to the kernel mailing list.
-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject 
<german@piraos.com>          | to receive my GnuPG public key.
