Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWBITMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWBITMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWBITMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:12:55 -0500
Received: from are.twiddle.net ([64.81.246.98]:65432 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1750716AbWBITMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:12:55 -0500
Date: Thu, 9 Feb 2006 11:12:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Andi Kleen <ak@suse.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: remove __alpha_cix__ and __alpha_fix__
Message-ID: <20060209191236.GA7259@twiddle.net>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	Andi Kleen <ak@suse.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru> <200602011124.29423.ak@suse.de> <20060202125007.GA5918@miraclelinux.com> <20060209055531.GA2642@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209055531.GA2642@miraclelinux.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 02:55:31PM +0900, Akinobu Mita wrote:
> -#if defined(__alpha_fix__) && defined(__alpha_cix__)
> +#ifdef CONFIG_ALPHA_EV67

What in the world is this supposed to fix?  You aren't seriously
suggesting that the compiler has stopped defining these, have you?


r~
