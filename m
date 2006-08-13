Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWHMPgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWHMPgh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHMPgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 11:36:36 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:59868 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751281AbWHMPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 11:36:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BHwkDJ+zNJ9fRmWGhErwtmY4+OdI5Ij49I8Gsa6M5blbVXkUeByimvIEBjMqxgwICKAS+Ua1ERKbjufeKzwH1HFmqNYAEEZ4Yyz2OwkLP/OWVXgNCZpz/4sKz4x7IeLXFQbXlvzr4nhPDvz1HkFF5D6JMNRVCFcN001BZErS9Ls=
Message-ID: <6b4360c80608130836t1169daf2vd5bc6a0a373989e8@mail.gmail.com>
Date: Sun, 13 Aug 2006 10:36:35 -0500
From: "Nick Manley" <darkhack@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ Issues with 2.6.17.8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried all sorts of kernels and distributions with similar
results. I decided to try Arch Linux and compile my own 2.6.17.8
kernel and see if it fixes any of the issues. It doesn't. The system
boots, but I have some odd errors that pevent certain things (like
ndiswrapper for example) from working correctly. In fact, ndiswrapper
causes a kernel panic. And no this isn't an ndiswrapper issue because
the kernel reports errors even without it installed. Ndiswrapper is
just an example of an application that is affected by it. I'll paste
my system files so you can see what errors are being reported.  I've
already attempted acpi=off, irqpoll, noapic, and other similar
commands in different combinations with no luck. The following logs
are from Kernel 2.6.17.8 with NO additional boot parameters attached.
The kernel was compiled on Arch Linux 0.72 with GCC 4.0.3.  Thank you
for your time...

dmesg - http://pastebin.ca/129538
errors.log - http://pastebin.ca/129542
everything.log - http://pastebin.ca/129545
lspci - http://pastebin.ca/129546
messages.log - http://pastebin.ca/129550
