Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278226AbRJSAJr>; Thu, 18 Oct 2001 20:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278229AbRJSAJh>; Thu, 18 Oct 2001 20:09:37 -0400
Received: from toad.com ([140.174.2.1]:40711 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278226AbRJSAJX>;
	Thu, 18 Oct 2001 20:09:23 -0400
Message-ID: <3BCF6F2E.DF35CC26@mandrakesoft.com>
Date: Thu, 18 Oct 2001 20:09:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org, ionut@cs.columbia.edu
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <Pine.LNX.4.33.0110181958290.10380-100000@prague.clic.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> other thing is, xircom_tulip_cb used to work on my system (2.4.10) (xircom
> realport card, rebranded for IBM), but with 2.4.12-ac3, it can't seem to
> drive the card.  it loads fine, detects the card, but no blinky lights.

It's critical that you get xircom_tulip_cb.c from 2.4.13-pre3. 
2.4.12-ac3 does not the long-needing-to-be-applied fixes that are now in
2.4.13-pre3's copy of the driver.

Ion (ionut@cs.columbia.edu) did the changes, so he is pretty close to
you if you need debugging, too <g>

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
