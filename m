Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279394AbRKARUO>; Thu, 1 Nov 2001 12:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279389AbRKARUE>; Thu, 1 Nov 2001 12:20:04 -0500
Received: from toad.com ([140.174.2.1]:20741 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S279394AbRKARTy>;
	Thu, 1 Nov 2001 12:19:54 -0500
Message-ID: <3BE18402.9F958EDC@mandrakesoft.com>
Date: Thu, 01 Nov 2001 12:18:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Stress testing 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0111010903280.11617-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Anyway, I seriously doubt this explains any real-world bad behaviour: the
> window for the interrupt hitting a half-way updated list is something like
> two instructions long out of the whole memory freeing path. AND most
> interrupts don't actually do any allocation.

Network Rx interrupts do....  definitely not as frequent as IDE
interrupts, but not infrequent.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
