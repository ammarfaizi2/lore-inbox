Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWCGX1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWCGX1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWCGX1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:27:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17345 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964804AbWCGX1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:27:48 -0500
Subject: Re: 2.6.16-rc5 huge memory detection regression
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <440E145B.7080006@ribosome.natur.cuni.cz>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
	 <20060307041532.3ef45392.akpm@osdl.org>
	 <440D7BB8.40106@ribosome.natur.cuni.cz>
	 <20060307113631.36ac029d.akpm@osdl.org>
	 <1141765722.9274.105.camel@localhost.localdomain>
	 <440E145B.7080006@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Date: Tue, 07 Mar 2006 15:26:46 -0800
Message-Id: <1141774006.9274.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 00:16 +0100, Martin MOKREJ© wrote:
> Hi Dave,
>    thanks for answer, the dmesg output is attached. I haven't tried 
> reverting your patch as suggested by Andrew yet. Would do tommorow 
> if still desired.
...
> 16256MB HIGHMEM available.
> 896MB LOWMEM available.

That looks to me like your top 8GB is back, right?

That printk() patch _really_ shouldn't have fixed it.  Can you verify by
booting back into your bad kernel?

-- Dave

