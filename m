Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbQLNPln>; Thu, 14 Dec 2000 10:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129802AbQLNPld>; Thu, 14 Dec 2000 10:41:33 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:11780 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129534AbQLNPlX>; Thu, 14 Dec 2000 10:41:23 -0500
Message-Id: <200012141510.eBEFAls48989@aslan.scsiguy.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        shirsch@adelphia.net, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 16:53:57 +0100."
             <3A38ED15.6EE42F31@evision-ventures.com> 
Date: Thu, 14 Dec 2000 08:10:47 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>What's wrong with current? It's perfectly fine, since it's the main data
>context entity you are working with during it's usage... Just remember
>it as
>CURRENT MAIN PROBLEM the kernel is struggling with at time.

What's wrong with the aic7xxx driver storing the "user", "goal", and
"current" transfer negotiation settings for a device in a structure
with fields by those names?  Nothing save the fact that "current" is
a #define in linux.

Anyway, I've said my peace.  The driver will properly work around
the namespace problem.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
