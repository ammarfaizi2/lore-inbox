Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbULGMuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbULGMuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 07:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbULGMuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 07:50:13 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:20682 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261800AbULGMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 07:50:07 -0500
Date: Tue, 7 Dec 2004 13:50:01 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: P@draigBrady.com, "David S. Miller" <davem@davemloft.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041207125001.GA26644@soohrt.org>
References: <20041206205305.GA11970@soohrt.org> <20041206134849.498bfc93.davem@davemloft.net> <20041206224107.GA8529@soohrt.org> <41B58A58.8010007@draigBrady.com> <20041207112139.GA3610@soohrt.org> <16821.42080.932184.167780@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16821.42080.932184.167780@robur.slu.se>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Olsson wrote:
> Well my experience is that it very hard not to say almost impossible to 
> extrapolate idle cpu into any network system capacity. I guess this is 
> what you are trying to do? 

Kinda, yes.
I'm trying to evaluate if the behaviour I'm seeing is expected, which
would heavily influence my choice of hardware/software for future
projects (and of course to optimize the current setup).

Currently I'm having problems capturing packets with tcpdump (lots of
"packets dropped by kernel") which indicates to me that there's
genuinely not much (enough) idle time sitting around.

> Rather load and overload the system with traffic having the characteristics
> you expect as a bonus you will get some kind proof of robustness and 
> responsiveness a max load. There are tools for this type of tests.

Will do, that could take a couple of days though.

Cheers,
 Karsten
