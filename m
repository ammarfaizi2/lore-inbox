Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRDRAFI>; Tue, 17 Apr 2001 20:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132904AbRDRAFB>; Tue, 17 Apr 2001 20:05:01 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:16904 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132883AbRDRAEo>;
	Tue, 17 Apr 2001 20:04:44 -0400
Message-ID: <00b101c0c799$948769c0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Subba Rao" <subba9@home.com>,
        "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010417194558.A10678@home.com>
Subject: Re: Adaptec 2940 and Linux 2.2.19
Date: Wed, 18 Apr 2001 11:52:57 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Subba Rao" <subba9@home.com>

>
> Hi,
>
> The kernel configuration menu items have been changing quite a bit. So, I
> apologize for asking a trivial question in this forum.
>
> I am trying to configure and install linux kernel 2.2.19. This system has
> a Adaptec 2940 SCSI adapter. I have enabled SCSI support kernel
configuration
> menu and also have selected all the Adaptec low-level drivers. They
include
> (actually what is offered), AHA152X/2825, AHA1542 and AHA1740. When the
kernel
> is booting up it still does not find the AHA2940 adapter.
>
> What (other) options should I configure to make Linux 2.2.19 find the
adapter?
>
> Thank you in advance for any help.
> --
>
> Subba Rao
> subba9@home.com
> http://members.home.net/subba9/
>


You want the Adaptec AIC7xxx driver. Should be listed right under those
other three.


Cheers

Simon Garner

