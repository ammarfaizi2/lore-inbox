Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSLBRaR>; Mon, 2 Dec 2002 12:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLBRaR>; Mon, 2 Dec 2002 12:30:17 -0500
Received: from [198.149.18.6] ([198.149.18.6]:46729 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264686AbSLBRaP>;
	Mon, 2 Dec 2002 12:30:15 -0500
Date: Mon, 2 Dec 2002 19:51:20 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021202195120.A25954@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <1033513407.12959.91.camel@phantasy> <20021104223725.A23168@sgi.com> <15851.37989.723028.614451@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15851.37989.723028.614451@harpo.it.uu.se>; from mikpe@csd.uu.se on Mon, Dec 02, 2002 at 06:12:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 06:12:05PM +0100, Mikael Pettersson wrote:
> Is this implementation of set_cpus_allowed() Ok for all 2.4 kernels,
> even if they (like RH8.0's) use a non-vanilla scheduler?

No, it's for the stock scheduler.  But RH8.0 already has set_cpus_allowed().

