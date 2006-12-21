Return-Path: <linux-kernel-owner+w=401wt.eu-S1753052AbWLUOVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbWLUOVM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbWLUOVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:21:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:57259 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbWLUOVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:21:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=LmCMV2sPLRLDbVFz8+50vYNuv/0m79sIJVM1Ws46Pqaoog8OSt8BgzGR43BKn1sYbTap9aisBn9iKrgtNfcSIk22XnA2XXPp8XR6ksNEO3wrOeYPtu0zAdEX3IooakoHMymdjFQO7FSjbtIli3UsQ+zMxs0mQozKIHhoa7+cx8I=
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling
	mechanism.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
In-Reply-To: <20061221140429.GA25214@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru>
	 <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org>
	 <20061221104918.GA16744@2ka.mipt.ru> <1166708885.3749.49.camel@localhost>
	 <20061221140429.GA25214@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 09:21:07 -0500
Message-Id: <1166710867.3749.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-21-12 at 17:04 +0300, Evgeniy Polyakov wrote:

> I modified world-wide used web server lighttpd and ran a lot of tests
> with it (compared to epoll version with major performance win).
> 
> I was asked yesterday by Jan Kneschke (lighttpd main developer) if
> kevent API is ready so he could include my patch into mainline lighttpd 
> tree, but I answered 'I do not know if kevent will be or not included, 
> everyone keeps silence'.
> 

Ok, so you are building the momentum then. People like Jan are the users
of such API and should be speaking up. Then kernel people will be forced
to look at it.

> I just do not know _what_ else should be done not even for inclusion - 
> but at least for some progress.

I know you are frustrated but stop doing the above like a broken vinyl
record, it doesnt help your case. 

> You want libevent to be patched? Its site is currently down, but ok, I
> will create a patch.
> 

I promise in 2 weeks to migrate an app or two that i have that use
libevent to your version if you have it by then. I will then test and
give you my opinion. 

cheers,
jamal

