Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUJEVuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUJEVuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUJEVuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:50:50 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:45979 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S266069AbUJEVun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:50:43 -0400
Message-ID: <416317FB.200@shadowconnect.com>
Date: Tue, 05 Oct 2004 23:54:03 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: question about MTRR areas on x86_64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i've got the following error message:

mtrr: type mismatch for fb000000,1000000 old: write-back new: write-combining
i2o: could not enable write combining MTRR

the output of /proc/mtrr is as follows:

reg00: base=0x00000000 (   0MB), size=8192MB: write-back, count=1
reg01: base=0xe5000000 (3664MB), size=  16MB: uncachable, count=1
reg02: base=0xe6000000 (3680MB), size=  32MB: uncachable, count=1
reg03: base=0xe8000000 (3712MB), size= 128MB: uncachable, count=1
reg04: base=0xf0000000 (3840MB), size= 256MB: uncachable, count=1

Could it be because the machine has too much memory, or is there a bug in the I2O driver?

Thank you very much in advance.


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
