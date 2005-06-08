Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVFHIVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVFHIVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVFHIVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:21:34 -0400
Received: from hrz-ws39.hrz.uni-kassel.de ([141.51.12.239]:16266 "EHLO
	hrz-ws39.hrz.uni-kassel.de") by vger.kernel.org with ESMTP
	id S262139AbVFHIVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:21:32 -0400
Message-ID: <42A6AAFF.2020605@uni-kassel.de>
Date: Wed, 08 Jun 2005 10:23:27 +0200
From: Michael Zapf <Michael.Zapf@uni-kassel.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with USB on x86_64
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-UniK-SMTP-MailScanner-Information: 
X-UniK-SMTP-MailScanner: Found to be clean
X-UniK-SMTP-MailScanner-SpamCheck: 
X-MailScanner-From: michael.zapf@uni-kassel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have some trouble using a memory stick of LG in my Athlon64 system. 
When I plug it in, dmesg gives messages like this:

ehci_hcd 0000:00:02.2: port 6 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
ehci_hcd 0000:00:02.2: port 6 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
hub 1-0:1.0: Cannot enable port 6.  Maybe the USB cable is bad?


and the stick cannot be mounted. It took some time of experimenting with 
different kernels to find out that

* using the 32-bit version of 2.6.8 or 2.6.11, the stick works fine, no 
error output!
* using the 64-bit version of 2.6.8 or 2.6.11, the problems occur as 
mentioned.

(2.6.8 as given by SuSE 9.2, 2.6.11 as by SuSE 9.3; both distributions 
offer a 32 and a 64-bit installation)
I also tried a Kubuntu 5.04 with 2.6.10, same result for 64 bit.

Does anybody have a good theory on what is happening here? Could this be 
a hardware problem?

Thanks for any hint,

Michael


