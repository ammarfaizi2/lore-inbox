Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRAYAbI>; Wed, 24 Jan 2001 19:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135272AbRAYAa6>; Wed, 24 Jan 2001 19:30:58 -0500
Received: from tech1.nameservers.com ([216.46.160.19]:17416 "EHLO
	tech1.nameservers.com") by vger.kernel.org with ESMTP
	id <S135200AbRAYAat>; Wed, 24 Jan 2001 19:30:49 -0500
Message-Id: <200101250030.QAA24585@tech1.nameservers.com>
To: linux-kernel@vger.kernel.org
Cc: Julian Anastasov <ja@ssi.bg>
Subject: Re: Turning off ARP in linux-2.4.0 
In-Reply-To: Your message of "Wed, 24 Jan 2001 09:21:02 GMT."
             <Pine.LNX.4.30.0101240857420.1024-100000@u.domain.uli> 
Date: Wed, 24 Jan 2001 16:30:49 -0800
From: Pete Elton <elton@iqs.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the 2.2 kernel, I could do the following:
> > echo 1 > /proc/sys/net/ipv4/conf/all/hidden
> > echo 1 > /proc/sys/net/ipv4/conf/lo/hidden
> >
> > The 2.4 kernel does not have these sysctl files any more.  Why was
> > this functionality taken out?  or was it simply moved to another place
> > in the proc filesystem?  How can I accomplish the same thing I was
> > doing in the 2.2 kernel in the 2.4 kernel?
> 
> 	You can use this temporary solution (the same patch ported to
> 2.3.41+):
> 
> http://www.linuxvirtualserver.org/arp.html
> http://www.linuxvirtualserver.org/hidden-2.3.41-1.diff

Thanks for the link to the patch.  I was able to get it patched
into the 2.4.0 kernel and it worked great.

Thanks.

Pete

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
