Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSAZRZt>; Sat, 26 Jan 2002 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSAZRZa>; Sat, 26 Jan 2002 12:25:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285666AbSAZRZI>;
	Sat, 26 Jan 2002 12:25:08 -0500
Message-ID: <3C52E671.605FA2F3@mandrakesoft.com>
Date: Sat, 26 Jan 2002 12:25:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Felix von Leitner <usenet-20020126@fefe.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about sparc 64-bit user land
In-Reply-To: <20020126171545.GB11344@fefe.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> 
> My understanding is that there is no 64-bit user land support for
> UltraSPARC, although the kernel runs in 64-bit mode.  Is that correct?
> If yes: why is that (still) so?

sparc64 has an in-kernel thunk layer that lets it run sparc32 binaries,
and a sparc32 userland.

Presumeably the standard benefits apply for 32 over 64 bits, such as
lower I-cache usage and smaller programs overall.  Though most
Linux/Unix applications seem to work ok on 64-bit, (a) some don't and
(b) few apps actually take good advantage of 64-bit machine int and
address space.

Of course, all that said, coming from an Alpha AXP background I prefer
64-bit userland ;-)

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
