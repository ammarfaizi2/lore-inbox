Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268574AbRGYOQL>; Wed, 25 Jul 2001 10:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268577AbRGYOQB>; Wed, 25 Jul 2001 10:16:01 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:19721 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S268574AbRGYOP6>;
	Wed, 25 Jul 2001 10:15:58 -0400
Date: Wed, 25 Jul 2001 16:54:45 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
To: "M. Tavasti" <tawz@nic.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Select with device and stdin not working
In-Reply-To: <m2snflm8s6.fsf@akvavitix.vuovasti.com>
Message-ID: <Pine.LNX.4.30.0107251653580.20130-100000@pccn3.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 25 Jul 2001, M. Tavasti wrote:

> But one would at least expect FD_ZERO() to really clean up rfds, and
> after it FD_SET() is used again, for every call of select().  And this
> code works fine in 2.0 kernels, and also with 2.2 and 2.4 if I'm using
> named pipe and stdin. Therefore I have strong belief problem is not
> usage of select() but something else.

Sorry, my bad. I misread your code.

Ketil


