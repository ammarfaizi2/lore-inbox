Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265949AbSKBMQo>; Sat, 2 Nov 2002 07:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbSKBMQo>; Sat, 2 Nov 2002 07:16:44 -0500
Received: from ns.suse.de ([213.95.15.193]:16398 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265949AbSKBMQm>;
	Sat, 2 Nov 2002 07:16:42 -0500
Date: Sat, 2 Nov 2002 13:23:12 +0100
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Message-ID: <20021102132312.A563@wotan.suse.de>
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <200211021203.gA2C37p24480@Port.imtp.ilyichevsk.odessa.ua> <20021102130954.A30729@wotan.suse.de> <200211021216.gA2CGEp24534@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211021216.gA2CGEp24534@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's easy to time memcpy() but harder to measure susequent
> cache misses when copied data gets accessed. We can read it
> back after memcpy and measure memcpy()+read, but is entire
> copy gets used immediately after memcpy() in real world usage?
> We're in benchmarking hell :(

You test common operations, like pipe bandwidth or ioctls.

-Andi
