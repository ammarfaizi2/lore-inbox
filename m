Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVDGIGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVDGIGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVDGIGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:06:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9402 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262201AbVDGIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:05:55 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Ian Campbell <ijc@hellion.org.uk>,
       Sven Luther <sven.luther@wanadoo.fr>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
References: <20050404141647.GA28649@pegasos>
	<20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos>
	<20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
	<20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	<1112689164.3086.100.camel@icampbell-debian>
	<20050405083217.GA22724@pegasos>
	<1112690965.3086.107.camel@icampbell-debian>
	<20050405091144.GA18219@lst.de>
	<1112693287.6275.30.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2005 13:22:36 -0600
In-Reply-To: <1112693287.6275.30.camel@laptopd505.fenrus.org>
Message-ID: <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Tue, 2005-04-05 at 11:11 +0200, Christoph Hellwig wrote:
> > On Tue, Apr 05, 2005 at 09:49:25AM +0100, Ian Campbell wrote:
> > > I don't think you did get a rejection, a few people said that _they_
> > > weren't going to do it, but if you want to then go ahead. I think people
> > > are just fed up of people bringing up the issue and then failing to do
> > > anything about it -- so prove them wrong ;-)
> > 
> > Actually patches to add firmware loader support to tg3 got rejected.
> 
> I think they will be accepted if they first introduce a transition
> period where tg3 will do request_firmware() and only use the built-in
> firmware if that fails. Second step is to make the built-in firmware a
> config option and then later on when the infrastructure matures for
> firmware loading/providing firmware it can be removed from the driver
> entirely.

For tg3 a transition period shouldn't be needed as firmware loading
is only needed on old/buggy hardware which is not the common case.
Or to support advanced features which can be disabled.

I am fairly certain in that case the firmware came from the bcm5701 
broadcom driver for the tg3 which I think is gpl'd.   So the firmware
may legitimately be under the GPL.

Eric
