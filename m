Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280718AbRKGAh0>; Tue, 6 Nov 2001 19:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRKGAhS>; Tue, 6 Nov 2001 19:37:18 -0500
Received: from mail124.mail.bellsouth.net ([205.152.58.84]:17467 "EHLO
	imf24bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280718AbRKGAfn>; Tue, 6 Nov 2001 19:35:43 -0500
Message-ID: <3BE881D0.B57FC763@mandrakesoft.com>
Date: Tue, 06 Nov 2001 19:35:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dalecki@evision.ag
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161FVT-00029X-00@the-village.bc.nu> <3BE883BF.1025EC08@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> And then there is the overloaded struct inde. It would be worth
> quite a bit of memmory to not overlay the private,filesystem
> specific parts but to attach them by a pointer instead, in esp.
> if you make this in a way where the private part would be used
> without the public interface in drivers.

I think there are plans for several filesystems to use the generic_ip
and generic_sbp members of the unions, instead of further adding to the
unions.  

FreeVxFS is an example of one such filesystem which already does this.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

