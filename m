Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVDEKpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDEKpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDEKpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:45:03 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:9710 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261657AbVDEKo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:44:58 -0400
Subject: Re: Netlink Connector / CBUS
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: johnpol@2ka.mipt.ru
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev <netdev@oss.sgi.com>, "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@redhat.com>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112686480.28858.17.camel@uganda>
References: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
	 <1112686480.28858.17.camel@uganda>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1112697888.1089.44.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 05 Apr 2005 06:44:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To be fair to Evgeniy I am not against the Konnector idea. I think that
it is a useful feature to have an easy to use messaging between
kernel-kernel and kernel-userspace. The fact that he leveraged netlink
instead of inventing things is a bonus. Having said that i have not
seriously scrutinized the code - and i think the idea of this new thing
hes tossing around called CBUS maybe pushing it.

cheers,
jamal

On Tue, 2005-04-05 at 03:34, Evgeniy Polyakov wrote:
> On Tue, 2005-04-05 at 01:10 -0400, Herbert Xu wrote:
> >On Tue, Apr 05, 2005 at 11:03:16AM +0400, Evgeniy Polyakov wrote:
> >> 
> >> I received comments and feature requests from Herbert Xu and Jamal Hadi
> >> Salim,
> >> almost all were successfully resolved.
> >
> >Please do not construe my involvement in these threads as endorsement
> >for this system.
> 
> Sure.
> I remember you are against it :).
> 
> >In fact to this day I still don't understand what problems this thing is
> >meant to solve.
> 
> Hmm, what else can I add to my words?
> May be checking the size of the code needed to broadcast kobject changes
> in kobject_uevent.c for example...
> Netlink socket allocation + skb handling against call to cn_netlink_send().
> 
> >-- 
> >Visit Openswan at http://www.openswan.org/
> >Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> >Home Page: http://gondor.apana.org.au/~herbert/
> >PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

