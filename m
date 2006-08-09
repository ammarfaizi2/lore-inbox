Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWHIQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWHIQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWHIQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:33:59 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:6627 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750740AbWHIQd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:33:58 -0400
Date: Wed, 9 Aug 2006 18:33:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sergei Steshenko <steshenko_sergei@list.ru>
Cc: Benoit Fouet <benoit.fouet@purplelabs.com>,
       Gene Heskett <gene.heskett@verizon.net>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward compatibilty?
Message-ID: <20060809163327.GB12571@mars.ravnborg.org>
References: <200608091140.02777.gene.heskett@verizon.net> <20060809184658.2bdfb169@comp.home.net> <44DA05C9.5050600@purplelabs.com> <20060809160043.GA12571@mars.ravnborg.org> <20060809191748.7550edaa@comp.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809191748.7550edaa@comp.home.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 07:17:48PM +0300, Sergei Steshenko wrote:
> On Wed, 9 Aug 2006 18:00:43 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Wed, Aug 09, 2006 at 05:56:57PM +0200, Benoit Fouet wrote:
> > > >
> > > >Demand stable ABI.
> > > >
> > > >  
> > > >
> > > sorry for the noise, but it's been a while now since i began reading
> > > mails from this list, and i must admit i don't always (never?) see the
> > > point of such messages...
> > > if you can help me understand, i'll be very happy to get something more
> > > detailed from you...
> > Documentation/stable_api_nonsense.txt
> > 
> > 	Sam
> > 
> 
> I love senselessness and technical incompetence of the document.
> 
> As I was taught at school, to prove that a statement is wrong one
> has to prove that it is wrong once.
> 
> Regardless of what the document says stable ABI can be achieved
> today - run a chosen Linux kernel version + chosen ALSA version under XEN or
> similar, and assign sound card to these (chosen Linux kernel version +
> chosen ALSA version).
Your focus is on user<->kernel API. The document is about kernel
internal API. Thats two different things and it was not clear if the
first poster was pointing at one or the other.

user<->kernel API is supposed to be stable - if ALSA breaks that then
ALSA has something to fix.

	Sam
