Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUHJIPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUHJIPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUHJIPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:15:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27542 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261375AbUHJIPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:15:23 -0400
Date: Tue, 10 Aug 2004 10:14:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Crawford <flacycads@access4less.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1 & mm2 break k3b
Message-ID: <20040810081453.GJ10381@suse.de>
References: <200408100011.30730.flacycads@access4less.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408100011.30730.flacycads@access4less.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Robert Crawford wrote:
> I posted this on the Con Kolivas kernel list, and he suggested I post
> here, regarding 2.6.8-rc3-mm kernels. I'm no expert by any means, but
> have been testing kernels since 2.5.67, and have posted about kernels
> on the Gentoo & PCLOS forums, among others.
> 
> "Just tested the latest staircase7.I with 2.6.8-rc3 vanilla, and
> 2.6.8-rc3-mm2, and both work fine- no problems I can see so far on my
> test box. However,  2.6.8-rc3-mm1 and mm2 both still break my k3b cd
> burning software, with these errors (using cdrecord 2.1a33, on Gentoo)
> :
> 
> Unable to determine the last tracks data mode. using default cdrecord
> returned an unknown error (code 12) Cannot allocate memory
> 
> Sometimes it says to lower the burn speed, even when it's set to 4x
> (on a 48x burner), but that doesn't solve the problem. I get the same
> errors.
> 
> This doesn't occur with all previous mm kernels (up to 2.6.8-rc2-mm2),
> or any other kernel I've tried, and not with any ck patches, so I'm
> convinced it's the rc3-mm patches causing this, and not anything ck."
> If I boot with other kernels, same hardware, same config file, k3b
> works perfectly.

Try 2.6.8-rc4, please.

-- 
Jens Axboe

