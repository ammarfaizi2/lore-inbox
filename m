Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281153AbRLDRpJ>; Tue, 4 Dec 2001 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRLDRnp>; Tue, 4 Dec 2001 12:43:45 -0500
Received: from mail213.mail.bellsouth.net ([205.152.58.153]:11013 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281647AbRLDRnF>; Tue, 4 Dec 2001 12:43:05 -0500
Message-ID: <3C0D0B21.732FBAF@mandrakesoft.com>
Date: Tue, 04 Dec 2001 12:42:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <ledzep37@attbi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver cleanups.
In-Reply-To: <E16BJ58-0002hg-00@the-village.bc.nu> <3C0D04A5.7090400@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> Once in 2.5.X will the ALSA drivers still be modular only or will they
> be able to be linked statically into the kernel as the current OSS
> drivers are able to be?

They will need to use module_init/exit, which allows static or modular
build at your choice.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

