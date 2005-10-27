Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVJ0UyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVJ0UyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVJ0UyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:54:05 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:19379
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932229AbVJ0UyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:54:04 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Roland Dreier <rolandd@cisco.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 16:54:03 -0400
Message-Id: <20051027204923.M89071@linuxwireless.org>
In-Reply-To: <52mzkuwuzg.fsf@cisco.com>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 13:44:19 -0700, Roland Dreier wrote
> Marcel> The BIOS and dmidecode tells me that I have 4 GB of RAM
>     Marcel> installed and I don't have any idea where to look for
>     Marcel> details. What information do you need to analyze this?
> 
> Look at the e820 dump in your kernel bootlog.  I'll bet you'll see a
> big chunk of reserved address space.  Do you have any PCI devices 
> like video cards that use a lot of PCI address space?
> 
> I don't know if EM64T systems (or whatever the right term is) have a
> way of remapping some RAM above 4 GB so that you can use all your
> memory in a case like this.

I think this always shows this amount of RAM. Windows does the same thing
AFAIK. It's basically some sort of limitation and the motherboard reports an
specific amount of memory.

There is a deeper reason, ask google.

(IA32 does not support all that much RAM, so it shows like 3.xxGB RAM but uses
the rest for System Resources like Video, PCI, bla bla)

EM64T is not really 64Bit so, is still IA32.

.Alejandro
