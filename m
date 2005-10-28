Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbVJ1I3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbVJ1I3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbVJ1I3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:29:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22596 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751623AbVJ1I3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:29:15 -0400
Date: Fri, 28 Oct 2005 10:29:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Jones <davej@redhat.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051028082944.GI11441@suse.de>
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com> <200510281007.42758.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510281007.42758.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28 2005, Arnd Bergmann wrote:
> In the example, bvec_alloc_bs does not initialize &idx when nr is not
> between 1 and BIO_MAX_PAGES, so gcc is telling the truth here.

Wrong. idx is always initialized if being used.

-- 
Jens Axboe

