Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbRHOXEk>; Wed, 15 Aug 2001 19:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbRHOXEa>; Wed, 15 Aug 2001 19:04:30 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:11535 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S268149AbRHOXET>;
	Wed, 15 Aug 2001 19:04:19 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
Date: 16 Aug 2001 01:04:30 +0200
Organization: Cistron Internet Services
Message-ID: <9lev5u$1kl$1@picard.cistron.nl>
In-Reply-To: <997911115.7088.4.camel@keller> <29219.997909757@redhat.com> <30038.997911777@redhat.com> <3B7AF05C.29521C46@zip.com.au>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B7AF05C.29521C46@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>I occasionally hear rumours about 3c59x failing with suspend/resume,
>but It Works For Me and nobody has stepped up with a solid problem
>description.  If someone _can_ reproduce this and is prepared to
>work it a bit, please let me know.

I can reproduce it reliably. 3c575 pcmcia card using 3c59x driver. 
Works fine until you suspend, and after a resume it no longer works
until you pop it out and reinsert it.

If you want anything tested let me know.

Wichert.


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

