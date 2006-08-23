Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWHWVwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWHWVwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWHWVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:52:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:13778 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965224AbWHWVwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:52:49 -0400
Date: Wed, 23 Aug 2006 16:52:46 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: Re: [PATCH 5/6]: powerpc/cell spidernet bottom half
Message-ID: <20060823215246.GH4401@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <20060818222657.GL26889@austin.ibm.com> <200608190103.05649.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608190103.05649.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:03:04AM +0200, Arnd Bergmann wrote:
> using the NAPI poll function

Still fiddling with this. Getting side-tracked after noticing
that the RX side generates a *huge* numbe of interrupts, despite
code in the driver which superficially appears to be RX NAPI.  
One step forward, two steps back, isn't there a dance like that?

--linas
