Return-Path: <linux-kernel-owner+w=401wt.eu-S1751208AbXAIJHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbXAIJHu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXAIJHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:07:49 -0500
Received: from colin.muc.de ([193.149.48.1]:1393 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbXAIJHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:07:48 -0500
Date: 9 Jan 2007 10:07:44 +0100
Date: Tue, 9 Jan 2007 10:07:44 +0100
From: Andi Kleen <ak@muc.de>
To: dean gaudet <dean@arctic.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] faster vgetcpu using sidt
Message-ID: <20070109090744.GA6346@muc.de>
References: <Pine.LNX.4.64.0701061807530.26307@twinlark.arctic.org> <Pine.LNX.4.64.0701081622270.12282@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701081622270.12282@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 64-bit processes can't actually use their 
> LDT can they?  

The kernel supports LDT for 64bit processes, it just is not commonly
used. 

-Andi
