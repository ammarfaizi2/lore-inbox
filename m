Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWFLKBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWFLKBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWFLKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:01:10 -0400
Received: from ns.firmix.at ([62.141.48.66]:17054 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751679AbWFLKBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:01:09 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, jdow <jdow@earthlink.net>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <1150106004.22124.155.camel@localhost.localdomain>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
	 <1150100286.26402.13.camel@tara.firmix.at>
	 <1150106004.22124.155.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 12 Jun 2006 12:01:01 +0200
Message-Id: <1150106461.6354.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.332 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 10:53 +0100, Alan Cox wrote:
> Ar Llu, 2006-06-12 am 10:18 +0200, ysgrifennodd Bernd Petrovitsch:
> > No. SPF simply defines legitimate outgoing MTAs for a given domain.
> 
> No it does not. If it did it would be almost a usable idea, but it fails
> because the ISP generally controls the definition and the users are more

ACK. The domain owner controls it. So if you are not happy with your
domain owner .....

[...]
> ISPs *love* SPF because they can enforce policies that allow them to
> charge even more to users who want to do anything interesting. The fact
> many of them don't allow users to control their own domain SPF or get a
> fixed SPF pointing at the ISP mailhost only is not entirely that they
> haven't gotten around to fixing it either.
> 
> The people who suffer from SPF are unfortunately the users. The people
> its alleged to stop like it. The people it is alleged to help run
> filters get richer and the users get screwed.
[....]
> SPF *would* be wonderful if the users controlled SPF handling and

Of course it would be much more useful (at least for the more
knowing/interested folks) if the user can specify "legitimate" email
(i.e. for the whole email address, not only th domain part).
This can be done since years with PGP-signatures but almost no one is
really using ist. And this requires understanding of PGP etc. - which is
unfortunately not the case for everyone.
So any simpler (but also reliable enough) scheme needs to be defined.

> someone fixed the forwarding flaws in it, but neither is the case today.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

