Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbRFGTQy>; Thu, 7 Jun 2001 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbRFGTQo>; Thu, 7 Jun 2001 15:16:44 -0400
Received: from paperboy.noris.net ([62.128.1.27]:48593 "EHLO mail2.noris.net")
	by vger.kernel.org with ESMTP id <S262903AbRFGTQf>;
	Thu, 7 Jun 2001 15:16:35 -0400
Mime-Version: 1.0
Message-Id: <p0510030bb74580aabb4a@[10.2.6.42]>
In-Reply-To: <15134.43914.98253.998655@pizda.ninka.net>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
 <3B1E5CC1.553B4EF1@alacritech.com>
 <15134.42714.3365.32233@theor.em.cig.mot.com>
 <15134.43914.98253.998655@pizda.ninka.net>
Date: Thu, 7 Jun 2001 21:11:38 +0200
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahem...

David S. Miller wrote:
>This allows people to make proprietary implementations of TCP under
>Linux.  And we don't want this just as we don't want to add a way to
>allow someone to do a proprietary Linux VM.

*Sigh* and thence begin the proprietary-vs-OpenSource flame wars again.

_Any_ open protocol can be abused for proprietary stuff. It can also 
be used for Something Entirely Different.

Personally, I would _love_ to have TCP as a module, just so that the 
system can unload it on my poor underpowered laptop when it's not 
needed.

The fact that you can abuse this ability in order to replace the 
current TCP with Something Proprietary And Therefore Evil is a 
no-brainer. Anybody can do exactly the same thing with my network 
card driver, or the Unix-domain code, or the NFS server, or ...

So what's so damn special about the TCP stack that you need to shout 
"Absolutely not" here? I don't get it.

-- 
Matthias Urlichs
