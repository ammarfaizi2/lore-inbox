Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263642AbTCUP5I>; Fri, 21 Mar 2003 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263643AbTCUP5I>; Fri, 21 Mar 2003 10:57:08 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:10771 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263642AbTCUP5H>; Fri, 21 Mar 2003 10:57:07 -0500
Date: Fri, 21 Mar 2003 16:08:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c_inc/dec_use_client in 2.5.x?
Message-ID: <20030321160806.A3322@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
References: <1048262264.11545.52.camel@ph58212.pharm.uu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048262264.11545.52.camel@ph58212.pharm.uu.nl>; from rbultje@ronald.bitfreak.net on Fri, Mar 21, 2003 at 04:57:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:57:44PM +0100, Ronald Bultje wrote:
> Hey,
> 
> what happened to above-mentioned functions? Well, yes, I can see that
> they're removed in 2.5.65 (probably earlier, I can't find them in any
> 2.5.x version), but why? Aren't the i2c client modules supposed to keep
> their use count dynamically anymore? i2c_client->inc/dec_use are gone
> too...

use try_module_get/module_put on ->owner.

