Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSAKHoP>; Fri, 11 Jan 2002 02:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289890AbSAKHoB>; Fri, 11 Jan 2002 02:44:01 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:22145 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S289888AbSAKHns> convert rfc822-to-8bit;
	Fri, 11 Jan 2002 02:43:48 -0500
Message-Id: <200201110742.g0B7gDa16387@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i810_audio driver v0.19 still freezes machine
Date: Fri, 11 Jan 2002 09:42:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: tom@infosys.tuwien.ac.at, linux-kernel@vger.kernel.org
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <3C3DEAFA.4070102@redhat.com>
In-Reply-To: <3C3DEAFA.4070102@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 January 2002 21:26, Doug Ledford wrote:
> Alan Cox wrote:
> > Make sure you test with both apic and non apic Doug. The previous hangs I
> > fixed up were specific to APIC mode because the APIC means the irq
> > arrival is later and more asynchronous
>
> I can't.  APIC makes my test machine (my only i810 machine) hang on boot

I have both 'Local APIC support on uniprocessors' and
'IO_APIC support on uniprocessors' enabled in kernel configuration.
Should I try i810_audio.c v0.19 after disabling APIC support in
kernel (v2.4.17)?

Andris


