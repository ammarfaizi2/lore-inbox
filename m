Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbRLSTav>; Wed, 19 Dec 2001 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285418AbRLSTab>; Wed, 19 Dec 2001 14:30:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285417AbRLSTa0>;
	Wed, 19 Dec 2001 14:30:26 -0500
Message-ID: <3C20EACF.DC97E803@mandrakesoft.com>
Date: Wed, 19 Dec 2001 14:30:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Wikne <wikne@lynx.uio.no>
CC: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com
Subject: Re: 2.4.16 rivafb memory recognition problem
In-Reply-To: <200112191616.RAA07423@lynx.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Wikne wrote:
> 
> Hi,
> 
> I discovered a strange behaviour related to kernel memory recognition
> when using the rivafb frame buffer option compiled into kernel 2.4.16.
> The system in question has a Asus AGP7700 nVidia GeForce 2 GTS (32MB)
> video card. It is a dual PIII SMP system, if that might matter.
> 
> When I select nVidia Riva support, at first it seemed to work perfectly.
> But then I discovered that the kernel only recognizes 32MB of total
> memory during boot! Excessive swapping is the result.
> 
> When instead I compile the kernel with VESA frame buffer support,
> all other kernel config parameters the same, the resulting kernel
> recognizes all of the 1GB physical memory actually installed in
> this box.

That code is based on the XFree86 code, maybe you can copy info from
XFree86's current driver...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
