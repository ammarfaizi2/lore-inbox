Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbTGJMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbTGJMWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:22:16 -0400
Received: from www.13thfloor.at ([212.16.59.250]:924 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S269244AbTGJMWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:22:05 -0400
Date: Thu, 10 Jul 2003 14:36:50 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710123650.GA16681@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F0CBC08.1060201@pobox.com> <20030710033409.GA1498@www.13thfloor.at> <1057836155.8005.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1057836155.8005.9.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 12:22:35PM +0100, Alan Cox wrote:
> On Iau, 2003-07-10 at 04:34, Herbert Pötzl wrote:
> > In my opinion (and you requested input *g*), the
> > kernel userland API can be changed as much as is
> > required to improve/stabilize/bugfix the kernel,
> > unless this change breaks something in userland
> > without an already available update/upgrade/etc ...
> 
> In a lot of cases (like O_DIRECT) its cleaner to simply break the API
> in a way that will spew warnings if people miss changes than mess around
> with extra methods that instead break drivers that forgot to use C99
> initializers.

yeah, I obviously forgot to mention this case ;)
and I agree that sometimes this is the best way
to do it ... 

but this is a little bit different because
a) you do it intentionally
b) you know how to fix it

> I plan to carry on breaking the kernel internal API when I have to
> and its easy to fix up the few affected users. I broke all the audio
> drivers between 2.4.21->22 but that was worth doing for example.

keep breaking the kernel internal ... 8-)

best,
Herbert

