Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUIUUOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUIUUOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUIUUOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:14:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:6301 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268048AbUIUUOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:14:35 -0400
Date: Tue, 21 Sep 2004 22:14:25 +0200
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available cmpxchg on i386
Message-ID: <20040921201425.GH18938@wotan.suse.de>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua> <20040921154542.GB12132@wotan.suse.de> <200409212306.38800.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409212306.38800.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like indirect jump is only slightly slower (on this CPU).

K7/K8 can predict indirect jumps. But most P3 and P4s can't (except for
the new Prescotts and Centrinos). And in all cases their jump predictor works 
worse.

-Andi
