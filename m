Return-Path: <linux-kernel-owner+w=401wt.eu-S932884AbXATCuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbXATCuv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbXATCuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:50:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:11168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882AbXATCuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:50:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j4v5yn3jVGEMOL6A5k7xxVQ1maf4h+wBz4zPy3bueuxR5JfOtaSP5csrVDMbtwyVKnx0BCcmzz4e89EXjF6nsoEN+XrP7gCGASOjIyBuXSEQ3d24OUZIbB4Pa6E3OUG47KjH+TIq5U6cVrlC7sCbbpKL4cLzYEHLzPmA3CHOuF0=
Message-ID: <8355959a0701191850kf3606e0h90c69827623bedfb@mail.gmail.com>
Date: Sat, 20 Jan 2007 08:20:48 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Missing dmesg parameters in 2.6.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Atlast I have succeeded in booting 2.6.19.2 on mutiple x86 machines. I
did observe a strange dmesg parameter behavior in this case:-


1) Compiling with SMP as Generic (CONFIG_X86_PC is not set, CONFIG_M686=y)

.........
.........
Using x86 segment limits to approximate NX protection
.........
.........
Using APIC driver default
.........
.........

2) Compiling with SMP as Processor specific (CONFIG_X86_PC=y,
CONFIG_MPENTIUM4=y)

I do not find the above mentioned parameters in this case.


I am trying to figure out what might have happened here? Any clues pl...


Thanks,

~Akula2
