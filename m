Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRB0UAC>; Tue, 27 Feb 2001 15:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRB0T7x>; Tue, 27 Feb 2001 14:59:53 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:20996 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129807AbRB0T7i>;
	Tue, 27 Feb 2001 14:59:38 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102271959.WAA21125@ms2.inr.ac.ru>
Subject: Re: New net features for added performance
To: ak@suse.DE (Andi Kleen)
Date: Tue, 27 Feb 2001 22:59:25 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010227010336.A25816@gruyere.muc.suse.de> from "Andi Kleen" at Feb 27, 1 03:15:08 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > 3) Enforce correct usage of it in all the networking :-)
> 
> ,) -- the tricky part.

No tricks, IP[v6] is already enforced to be clever; all the rest are free
to do this, if they desire. And btw, driver need not to parse anything,
but its internal stuff and even aligning eth II header can be made
in eth_type_trans().

Actually, it is possible now not changing anything but driver.
Fortunately, I removed stupid tulip from alpha, so that I have
no impetus to try this myself. 8)

Alexey
