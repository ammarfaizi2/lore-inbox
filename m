Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVL0HNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVL0HNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVL0HNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:13:08 -0500
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:22982 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S932248AbVL0HNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:13:05 -0500
Date: Tue, 27 Dec 2005 16:12:56 +0900 (JST)
Message-Id: <200512270712.jBR7Cvq0016461@toshiba.co.jp>
To: willy@w.ods.org
Cc: yasuyuki.kozakai@toshiba.co.jp, kernel@linuxace.com, gregkh@suse.de,
       gcoady@gmail.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.14.5
From: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
In-Reply-To: <20051227065844.GA14828@alpha.home.local>
References: <20051227060714.GA1053@linuxace.com>
	<200512270641.jBR6f6vt024777@toshiba.co.jp>
	<20051227065844.GA14828@alpha.home.local>
X-Mailer: Mew version 4.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Willy Tarreau <willy@w.ods.org>

> On Tue, Dec 27, 2005 at 03:41:05PM +0900, Yasuyuki KOZAKAI wrote:
> > From: Phil Oester <kernel@linuxace.com>
> > Date: Mon, 26 Dec 2005 22:07:14 -0800
> > 
> > > On Tue, Dec 27, 2005 at 06:45:19AM +0100, Willy Tarreau wrote:
> > > > On Tue, Dec 27, 2005 at 04:42:00PM +1100, Grant Coady wrote:
> > > > > + iptables -A INPUT -p all --match state --state ESTABLISHED,RELATED -j ACCEPT
> > > > > iptables: No chain/target/match by that name
> > > > 
> > > > So it's not only the NEW state, it's every "--match state".
> > > 
> > > Odd...works fine here
> > 
> > Willy, which version of iptables is ?
> > And kernel config around netfilter would be helpful.
> 
> Hey, it's Grant who has the problem, not me. Anyway, he fixed it,
> it seems it was related to an invalid .config.

Sorry about this, and thanks for report.

-- Yasuyuki Kozakai
