Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278235AbRJSALr>; Thu, 18 Oct 2001 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278229AbRJSALh>; Thu, 18 Oct 2001 20:11:37 -0400
Received: from toad.com ([140.174.2.1]:43527 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278227AbRJSAL0>;
	Thu, 18 Oct 2001 20:11:26 -0400
Message-ID: <3BCF6FE9.1D5D9750@mandrakesoft.com>
Date: Thu, 18 Oct 2001 20:12:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: ionut@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <Pine.LNX.4.33.0110181958290.10380-100000@prague.clic.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> if it doesn't need promiscious mode always, shouldn't this be a module
> param?

There is a significant enough portion of Xircom cards that have that
particular quirk, that relegating the option to a not-enabled-by-default
setting would mean some people's cards flat out don't work by default
with the driver.  Ugly user support issue, even if it is easily solved.

I am hoping that Ion's changes make unconditional promisc mode
unnecessary..

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
