Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131978AbQKBO17>; Thu, 2 Nov 2000 09:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132026AbQKBO1j>; Thu, 2 Nov 2000 09:27:39 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:64344 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S131978AbQKBO13>;
	Thu, 2 Nov 2000 09:27:29 -0500
Message-ID: <3A0179BC.670CEE77@ife.ee.ethz.ch>
Date: Thu, 02 Nov 2000 15:27:08 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <Pine.LNX.3.95.1001102091346.8760A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> The specification is bogus and should be fixed. select() is not

Don't tell me, I didn't write that spec.

> side-affects is patently wrong. ioctl() was designed to control
> things.

It already exists, ioctl(fd, SNDCTL_DSP_SETTRIGGER, PCM_ENABLE_INPUT).
If we officially declare the poll/select side effect to be
unacceptable, I'm happy with it, as my sound drivers already
work that way 8-)

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
