Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272250AbTGYSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272251AbTGYSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:47:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7808
	"EHLO x30.random") by vger.kernel.org with ESMTP id S272250AbTGYSr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:47:29 -0400
Date: Fri, 25 Jul 2003 15:02:20 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030725190220.GD2659@x30.random>
References: <200307231521.15897.rathamahata@php4.ru> <20030725052818.GA6440@x30.random> <200307251510.59062.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307251510.59062.rathamahata@php4.ru>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, Jul 25, 2003 at 03:10:59PM +0400, Sergey S. Kostyliov wrote:
> I doubt it depends on bigpages because they
> are not used in my setup. But I can live with that. Rule: do not run
> `swapoff -a` under load doesn't sound as impossible in my case (if this
> is the only way to trigger this problem). 

can you reproduce it with 2.4.21rc8aa1? If not, then likely it's a
2.5/2.6 bug that went in 2.4 during the backport. I spoke with Hugh an
hour ago about this, he will soon look into this too.

Andrea
