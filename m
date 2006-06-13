Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWFMRln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWFMRln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWFMRln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:41:43 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:62600 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750824AbWFMRlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:41:42 -0400
Date: Tue, 13 Jun 2006 20:41:40 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060613174140.GC27502@mea-ext.zmailer.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060611072223.GA16150@flint.arm.linux.org.uk> <20060612083239.GA27502@mea-ext.zmailer.org> <448D8B2F.8060405@ti-wmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448D8B2F.8060405@ti-wmc.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:41:35PM +0200, Simon Oosthoek wrote:
> Hi Matti

Hello Simon,  for a change somebody who gets my name correctly :-)
(Just today I did teach a Londoner to pronounce that double-t properly,
it did sound weird...)

> Matti Aarnio wrote:
> >
> >For a very long time (like 20 years or so) I used to think like that.
> >
> >Doing email services in big ISP environments for about 10 years did
> >cure me of that thinking.  Ordinary Janes and Joes (and grannies
> >and granpas) must not be allowed to send email in similar ways that
> >we used to do in happy 1980es when the internet was engineer playground.
> 
> This is so against the spirit and meaning of the Internet, you're not 
> talking about the network we call Internet. You're talking about two 
> tiered internet, which is bad too.

Yes, I agree.  Surprisingly by calling it "security enhanced" or something,
ISPs can  _charge_more_,  and users are happy to buy it!  (I have seen this
happening in Finland.)

I have also seen compartementalisation(sp?) failures resulting from
"these customer networks can send email via those SMTP servers" - and
then a user changes access provider, but not email provider (or does
not know how to change OE configurations to match..)
There a widely adopted SMTP SUBMISSION protocol (SMTP on TCP port 587
and _requiring_ at least sender authentication before _any_ sort of
sending is allowed - preferrably under TLS) would make that subset
of users isp-change problems moot.
Also the server configuration is simple: "user did authenticate ok,
let it send that email" - no network ACLs to keep up at all.

With authentication done, ISP can even verify source address validity
on the submission, or perhaps choose not to verify..  It might again
be a positive sales argument.

Travellers would have _easy_ access to their "home postoffice" over
the network, and be able to send email authenticated no matter where
they are, and in whose network _without_need_to_find_ that local SMTP
server that lets them send their email...

Of course ISPs would need to  a)  enable the service (and do it
correctly),  b)  educate their users to use it.


And this, by the way, is something that I do think that people SHOULD
use, no matter if SPF (or its likes) ever makes it mandatory.

It will block tons of email viruses from sending themselves around,
until they learn to pick user's submission authentication data.
.. and when they do, service provider can block that USER whose
account is misused.


> >The Internet needs to be segregated into two kinds of users - those that
> >must not be allowed to do much of anything ( = common man to whom the
> >internet equals anyway to IE web-browser ) and to first-class citizens
> >with their own email servers...
> 
> Why don't you go fork the Internet then? Go see if that will work?
> 
> This whole discussion is kind of ridiculous for an open source project 
> like the linux kernel. If you're so keen on fixing e-mail, you should 
> work closely with the IETF working groups to create a new standard that 
> works.

Do read RFC 2821/2822 credits section.

I have been on this business quite a while :-)

> Finally, if you consider doing this, why not consider closing the 
> mailinglist to a subscription only list, that will work so much better 
> than this "free lunch" (to quote someone else)
> 
> Cheers
> Simon

Cheers from London,
  Matti Aarnio
