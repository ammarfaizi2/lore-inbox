Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288547AbSANBOu>; Sun, 13 Jan 2002 20:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSANBOg>; Sun, 13 Jan 2002 20:14:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:45330 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288547AbSANBOV>;
	Sun, 13 Jan 2002 20:14:21 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Roman Zippel <zippel@linux-m68k.org>, Kenneth Johansson <ken@canit.se>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PvKx-00005L-00@the-village.bc.nu>
In-Reply-To: <E16PvKx-00005L-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 20:17:11 -0500
Message-Id: <1010971032.1528.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 19:50, Alan Cox wrote:

> Do you want a clean simple solution or complex elegance ? For 2.4 I definitely
> favour clean and simple. For 2.5 its an open debate

Make no mistake, I do not intend to see preempt-kernel in 2.4.  I will,
however, continue to maintain the patch for endusers and such that use
it.  A proper in-kernel solution for 2.4 in my opinion in mini-ll,
perhaps extend with any other obviously-completely-utterly sane bits
from full-ll.

For 2.5, however, I tout preempt as the answer.  This does not mean just
preempt.  It means a preemptible kernel as a basis for beginning
low-latency works in manners other than explicit scheduling statements.

	Robert Love

