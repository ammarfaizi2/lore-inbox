Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTJSTmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTJSTmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:42:47 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:22156 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262114AbTJSTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:42:45 -0400
Subject: Re: HighPoint 374
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: linux-kernel@vger.kernel.org, tomi.orava@ncircle.nullnet.fi
Content-Type: text/plain
Message-Id: <1066592564.745.12.camel@bonnie79>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 21:42:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> What's the current status of HPT 374 support? Is it working in any
>>> kernel
>>> version?
>>
>> In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
>> "experimental" IDE Raid with two disks on a HPT 374 controller with the
>> drivers that come with the kernel.
>
>I have tried these versions in the past as well without success.
>However, I don't use HPT-raid features at all ie. I'm using the
>disks as JBOD. What hardware do you have and have you enabled
>ACPI/local-apic/io-apic ? What brand & model of disk-drives you
>are using with HPT374 controller ? And finally what does
>the /proc/interrupts show for you ?
>
>There really must be some explanation why some of us are
>having really huge problems with HPT374-contollers while for
>others it's working just fine. I haven't exactly heard anyone
>been too succesfull for example with Epox 8K9A3+ motherboard
>even on this mailing-list based on previous questions seen here.

well, it's not an Epox 8k9a3+ here, but an 8k5a3+ with two HPT374 onboard
and it is working well with recent 2.6.0-test* kernels.
I also just use JBOD - only one disk connected as /dev/hde to the first HPT 374, 
an IBM-DTLA-305040, and I really don't see any probs here.

Christian



