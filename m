Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFJSPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFJSPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:15:46 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:1411
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261428AbTFJSPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:15:38 -0400
Date: Tue, 10 Jun 2003 14:15:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, "" <willy@w.ods.org>, "" <gibbs@scsiguy.com>,
       "" <marcelo@conectiva.com.br>, "" <green@namesys.com>
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030610194429.615c0e93.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.50.0306101412350.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
 <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
 <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
 <20030605181423.GA17277@alpha.home.local> <20030608131901.7cadf9ea.skraw@ithnet.com>
 <20030608134901.363ebe42.skraw@ithnet.com> <20030609171011.7f940545.skraw@ithnet.com>
 <Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
 <20030610123015.4242716e.skraw@ithnet.com>
 <Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
 <20030610153815.57f7a563.skraw@ithnet.com>
 <Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
 <20030610194429.615c0e93.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Stephan von Krawczynski wrote:

> The controller used is the second aic7xxx. The 31 interrupts on CPU0 have
> occured before the test. This setup fails during verify (data corruption).
> 
> I would say that the interrupt code of the aic in itself is therefore ok with
> SMP. If it were a SMP race condition inside the interrupt routine this test
> should have been ok (as only one CPU is used).

Thanks for verifying this, at least i know the problem isn't with 
interrupt routing in your specific case.

	Zwane
-- 
function.linuxpower.ca
