Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFJBgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 21:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFJBgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 21:36:15 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:19843
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262366AbTFJBgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 21:36:12 -0400
Date: Mon, 9 Jun 2003 21:38:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, "" <willy@w.ods.org>, "" <gibbs@scsiguy.com>,
       "" <marcelo@conectiva.com.br>, "" <green@namesys.com>
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030609171011.7f940545.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
 <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
 <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
 <20030605181423.GA17277@alpha.home.local> <20030608131901.7cadf9ea.skraw@ithnet.com>
 <20030608134901.363ebe42.skraw@ithnet.com> <20030609171011.7f940545.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Stephan von Krawczynski wrote:

> During the whole testing with SMP I recognised that the tar-verify always
> brought up "content differs" warnings. Which basically means that the filesize
> is ok but the content is not. As there might be various causes for this (bad
> tape, bad drive, bad cabling) I did not give very much about it. But it turns
> out there are no more such warnings when using an UP kernel (on the same box
> with the complete same hardware including tapes).
> 
> >From this experience I would conclude the following (for my personal test
> case):

Can you also try this with 2.5?

> 1) aic-driver has problems with smp/up switching (meaning crashes when trying
> an SMP build with nosmp). This is completely reproducable.

Can you also try an SMP kernel with noapic?

> 2) aic-driver (almost no matter what version) has problems with SMP setup and
> tape drives. Obviously data integrity is not given. This is completely
> reproducable in my test setup.

I have had problems with symmetric interrupt handling but can normally get 
it working with noapic. And no it doesn't appear to be an interrupt 
routing problem on my box (If it is someone please clearly state what the 
exact problem is to me)

	Zwane
-- 
function.linuxpower.ca
