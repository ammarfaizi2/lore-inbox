Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131731AbRCUS6Z>; Wed, 21 Mar 2001 13:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131736AbRCUS6P>; Wed, 21 Mar 2001 13:58:15 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:33039 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S131731AbRCUS55>;
	Wed, 21 Mar 2001 13:57:57 -0500
To: Francois Romieu <romieu@cogenit.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] 2.4.3-pre6 - hdlc/dscc4 missing bits
In-Reply-To: <20010321163031.A28981@se1.cogenit.fr>
	<3AB8CDE0.2B2619AF@mandrakesoft.com>
	<20010321173930.A29474@se1.cogenit.fr>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 21 Mar 2001 19:53:42 +0100
In-Reply-To: Francois Romieu's message of "Wed, 21 Mar 2001 17:39:30 +0100"
Message-ID: <m3pufbj6mh.fsf_-_@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> What about the following (2.5 ?):
> 
> -		dev->type = ARPHRD_HDLC;
> +		dev->type = ARPHRD_CISCO;

I'll replace ARPHRD_HDLC with ARPHRD_CISCO in the whole (AC) tree when
2.4.x kernel with '#define ARPHRD_CISCO' is out, leaving ARPHRD_HDLC only
in the header file for possible external drivers. It can then be removed
in 2.5.
-- 
Krzysztof Halasa
Network Administrator
