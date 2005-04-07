Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVDGLc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVDGLc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVDGLc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:32:58 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:22167 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262436AbVDGLbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:31:31 -0400
X-ME-UUID: 20050407113130355.56D671C00096@mwinf0706.wanadoo.fr
Date: Thu, 7 Apr 2005 13:27:38 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407112738.GB8508@pegasos>
References: <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 01:22:36PM -0600, Eric W. Biederman wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Tue, 2005-04-05 at 11:11 +0200, Christoph Hellwig wrote:
> > > On Tue, Apr 05, 2005 at 09:49:25AM +0100, Ian Campbell wrote:
> > > > I don't think you did get a rejection, a few people said that _they_
> > > > weren't going to do it, but if you want to then go ahead. I think people
> > > > are just fed up of people bringing up the issue and then failing to do
> > > > anything about it -- so prove them wrong ;-)
> > > 
> > > Actually patches to add firmware loader support to tg3 got rejected.
> > 
> > I think they will be accepted if they first introduce a transition
> > period where tg3 will do request_firmware() and only use the built-in
> > firmware if that fails. Second step is to make the built-in firmware a
> > config option and then later on when the infrastructure matures for
> > firmware loading/providing firmware it can be removed from the driver
> > entirely.
> 
> For tg3 a transition period shouldn't be needed as firmware loading
> is only needed on old/buggy hardware which is not the common case.
> Or to support advanced features which can be disabled.
> 
> I am fairly certain in that case the firmware came from the bcm5701 
> broadcom driver for the tg3 which I think is gpl'd.   So the firmware
> may legitimately be under the GPL.

So, where is the source for it ? 

Friendly,

Sven Luther

