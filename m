Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270429AbRHHJ02>; Wed, 8 Aug 2001 05:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270430AbRHHJ0S>; Wed, 8 Aug 2001 05:26:18 -0400
Received: from t2.redhat.com ([199.183.24.243]:37362 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S270429AbRHHJ0H>; Wed, 8 Aug 2001 05:26:07 -0400
Message-ID: <3B7105B5.34B4F9C@redhat.com>
Date: Wed, 08 Aug 2001 10:26:13 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-0.9smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Borntraeger <CBORNTRA@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:

> I tried the Patch from http://www.zip.com.au/~akpm/ext3-2.4-0.9.5-247.gz
> with the kernel 2.4.7 with a new LVM- patch(0.9.1)  and some S/390 specific
> patches. I use mke2fs version 1.22.
> S/390 is a 32bit big endian machine. After compiling and running the kernel
> I created an ext3-file system on an 70GB LVM. When running the postmark
> test I get (reproduceable) the message from above. dmesg shows:

It would be interesting to know if this still happends without a beta
version of LVM,
and without LVM at all.

Greetings,
   Arjan van de Ven
