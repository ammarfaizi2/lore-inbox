Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265944AbSKBMD0>; Sat, 2 Nov 2002 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265946AbSKBMD0>; Sat, 2 Nov 2002 07:03:26 -0500
Received: from ns.suse.de ([213.95.15.193]:29452 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265944AbSKBMDZ>;
	Sat, 2 Nov 2002 07:03:25 -0500
Date: Sat, 2 Nov 2002 13:09:54 +0100
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Message-ID: <20021102130954.A30729@wotan.suse.de>
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <3DC3A9C0.7979C276@digeo.com.suse.lists.linux.kernel> <p73y98cqlv3.fsf@oldwotan.suse.de> <200211021203.gA2C37p24480@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211021203.gA2C37p24480@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That depends on size. If you do huge memcpy (say 1 mb) it still
> wins by wide margin. Not that we do such huge operations often,
> but code can check size and pick different routines for small
> and big blocks

The kernel nevers does such huge memcpys. It rarely does handle any buffer
bigger than a page (4K) 

-Andi
