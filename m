Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSA3IjD>; Wed, 30 Jan 2002 03:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSA3Iix>; Wed, 30 Jan 2002 03:38:53 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:28400 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288742AbSA3Iih>; Wed, 30 Jan 2002 03:38:37 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020129191424.U5808@mea-ext.zmailer.org> 
In-Reply-To: <20020129191424.U5808@mea-ext.zmailer.org>  <Pine.LNX.4.21.0201291533430.10745-100000@reactor.hyte.de> <3C56CFBD.6060100@antefacto.com> 
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: that virus thing.... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Jan 2002 08:38:29 +0000
Message-ID: <9247.1012379909@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matti.aarnio@zmailer.org said:
>   No.  It means the real message originator, invisible because that
>   system apparently does not retain  Received: headers, sent out:
>       From: <Administrator>
>   and VGER was the first machine receiving it, and following the letter
>   of RFC 822 about fully-qualified addresses in visible headers, and
>   qualified a non-qualified one... 

It's too early in the morning for reading RFCs. Does RFC2822 say you should
add your own domain to unqualified addresses in non-local mail, or just 
say that unqualified addresses aren't legal?

If the latter, rejecting the offending mail would seem more appropriate 
than adding '@vger.kernel.org' to it.

Might also be useful to stop any mail with null reverse-path from getting 
to the list - or do we already do that and the ones that slipped through 
couldn't even get that right?

--
dwmw2


