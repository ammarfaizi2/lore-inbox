Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTGSEX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 00:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270491AbTGSEX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 00:23:29 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:9834 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S270490AbTGSEX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 00:23:27 -0400
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bourne <jbourne@hardrock.org>, breed@users.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030718200013.40e983f6.akpm@osdl.org>
References: <20030718140414.371cdb55.akpm@osdl.org>
	 <Pine.LNX.4.44.0307182044420.22990-100000@cafe.hardrock.org>
	 <20030718200013.40e983f6.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1058589381.3434.11.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jul 2003 00:36:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-18 at 23:00, Andrew Morton wrote:
> James Bourne <jbourne@hardrock.org> wrote:
> >
> > > I've been waiting months for someone to test this patch.  Can you please do
> >  > so?
> > 
> >  Well, the error is gone, unfortunately I won't have anything for the card to
> >  talk to until monday (or if I take my laptop for a car ride...).
> 
> Well Daniel Ritz has posted a big fix to the driver so I threw mine away. 
> I'll include it in the next -mm, so please test that.

I've applied Daniel's patch to my 2.6.0-test1-mm1 tree on two of my test
systems (a PCMCIA and PCI version of the Aironet 350 series) and both
are working great.  His patches look pretty obviously correct to me and
are much cleaner than the hacked up patches I've been sending out to
people to get the card working on recent 2.5.7x kernels.  Just wanted to
report the success.

Later,
Tom


