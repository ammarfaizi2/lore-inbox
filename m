Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUFAMa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUFAMa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAMa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:30:59 -0400
Received: from [213.239.201.226] ([213.239.201.226]:15296 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265014AbUFAMa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:30:57 -0400
Message-ID: <40BC788A.3020103@shadowconnect.com>
Date: Tue, 01 Jun 2004 14:37:30 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with ioremap which returns NULL in 2.6 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

could someone help me with a ioremap problem. If there are two 
controllers plugged in, the ioremap request for the first controller is 
successfull, but the second returns NULL. Here is the output of the driver:

i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 0 at 72.
i2o: PCI I2O controller at 0xD0000000 size=134217728
I2O: MTRR workaround for Intel i960 processor
i2o/iop0: Installed at IRQ17
i2o: I2O controller on bus 0 at 96.
i2o: PCI I2O controller at 0xD8000000 size=134217728
i2o: Unable to map controller.

I've seen that there was a problem with 2.4 already, but didn't find it 
with 2.6. Please could someone help me how to resolve this problem?

Any help is appreciated.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

