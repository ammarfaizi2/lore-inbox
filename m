Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbULGNEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbULGNEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULGNEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:04:40 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:29098 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261803AbULGNEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:04:38 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, P@draigBrady.com,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041207125001.GA26644@soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
	 <20041206134849.498bfc93.davem@davemloft.net>
	 <20041206224107.GA8529@soohrt.org> <41B58A58.8010007@draigBrady.com>
	 <20041207112139.GA3610@soohrt.org> <16821.42080.932184.167780@robur.slu.se>
	 <20041207125001.GA26644@soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102424673.1093.124.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Dec 2004 08:04:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 07:50, Karsten Desler wrote:

> Currently I'm having problems capturing packets with tcpdump (lots of
> "packets dropped by kernel") which indicates to me that there's
> genuinely not much (enough) idle time sitting around.
> 

Ah, more hints. So you are not trying to forward - rather just packet
capturing?
Are you using a tcpdump patched with mmaped packet socket?

The 230-240Kpps you are reporting as a capture dont seem as unreasonable
as i thought then. Neither would the CPU use.

cheers,
jamal

