Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUHIVcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUHIVcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHIV2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:28:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28843 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267287AbUHIV2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:28:05 -0400
Date: Mon, 9 Aug 2004 17:26:03 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040809202603.GA7776@logos.cnet>
References: <20040809195656.GX26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809195656.GX26174@fs.tum.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 09:56:56PM +0200, Adrian Bunk wrote:
> 
> The contract is easy:
> If you select something, you have to ensure the depenencies of the 
> selected option are met.
> 
> This is simple.
> 
> And most people get it wrong.
> 
> The patch below adds dependencies on HOTPLUG for all options that select 
> FW_LOADER.

BTW last time I tried to turn CONFIG_FW_LOADER off on 2.6.8-rc3 I was not able
to do so... Is that expected?
