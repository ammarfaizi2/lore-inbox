Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUAHIsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUAHIsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:48:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29709 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263927AbUAHIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:48:10 -0500
Date: Thu, 8 Jan 2004 09:47:58 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-ID: <20040108084758.GB9050@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local> <3FFCC430.4060804@candelatech.com> <20040108091441.3ff81b53.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108091441.3ff81b53.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 09:14:41AM +0100, Stephan von Krawczynski wrote:
> the situation is like this (exactly this works flawlessly with tulip):
> 
> - unplug all interfaces from the switches
> - reboot box
> - plug in _one_ interface 
> - log into the box (yes, network works flawlessly)
> - start keepalived
> - now plug in rest of the interfaces
> - watch keepalived do _nothing_ (seems no UP event shows up)

I agree with this description, and would add :
  - mii-diag ethX or ethtool ethX report link down

Willy

