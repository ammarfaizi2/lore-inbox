Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUAHIqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUAHIqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:46:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28685 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263927AbUAHIqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:46:22 -0500
Date: Thu, 8 Jan 2004 09:46:05 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-ID: <20040108084605.GA9050@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local> <3FFCC430.4060804@candelatech.com> <20040108052000.GA8829@alpha.home.local> <3FFD0FAE.8050705@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFD0FAE.8050705@candelatech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 12:07:10AM -0800, Ben Greear wrote:
 
> No, I meant what I said:  You have to tell many drivers to bring the 
> interface
> up before they will attempt (or at least report) link negotiation.
> You do NOT have to give it an IP address or add any routes to it.

ah, OK. No, anyway, it is just a matter of wrongly detecting link state
after the link has been plugged while the interface was already UP, no
matter if an IP was set or not.

> But, I don't know about your particular program, I just suspect it
> is related to detecting link state.  I think tg3 detects link when
> the interface is not UP, if you have some tg3 nics maybe you could
> try with them?

As far as I have tested, tg3 are fine WRT this.

Willy

