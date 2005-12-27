Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVL0G71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVL0G71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 01:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVL0G71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 01:59:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42250 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932251AbVL0G71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 01:59:27 -0500
Date: Tue, 27 Dec 2005 07:58:44 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
Cc: kernel@linuxace.com, willy@w.ods.org, gregkh@suse.de, gcoady@gmail.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.14.5
Message-ID: <20051227065844.GA14828@alpha.home.local>
References: <3ok1r15khvs8gka6qhhvt3u302mafkkr2r@4ax.com> <20051227054519.GA14609@alpha.home.local> <20051227060714.GA1053@linuxace.com> <200512270641.jBR6f6vt024777@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512270641.jBR6f6vt024777@toshiba.co.jp>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 03:41:05PM +0900, Yasuyuki KOZAKAI wrote:
> 
> Hi,
> 
> From: Phil Oester <kernel@linuxace.com>
> Date: Mon, 26 Dec 2005 22:07:14 -0800
> 
> > On Tue, Dec 27, 2005 at 06:45:19AM +0100, Willy Tarreau wrote:
> > > On Tue, Dec 27, 2005 at 04:42:00PM +1100, Grant Coady wrote:
> > > > + iptables -A INPUT -p all --match state --state ESTABLISHED,RELATED -j ACCEPT
> > > > iptables: No chain/target/match by that name
> > > 
> > > So it's not only the NEW state, it's every "--match state".
> > 
> > Odd...works fine here
> 
> Willy, which version of iptables is ?
> And kernel config around netfilter would be helpful.

Hey, it's Grant who has the problem, not me. Anyway, he fixed it,
it seems it was related to an invalid .config.

> Regards,
> 
> -- Yasuyuki Kozakai

Regards,
willy

