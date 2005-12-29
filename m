Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVL2TwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVL2TwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVL2TwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:52:04 -0500
Received: from waste.org ([64.81.244.121]:62417 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750920AbVL2TwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:52:02 -0500
Date: Thu, 29 Dec 2005 13:48:03 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make sysenter support optional
Message-ID: <20051229194802.GA3356@waste.org>
References: <20051228212402.GX3356@waste.org> <20051229084858.GA31412@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229084858.GA31412@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 09:48:58AM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > This adds configurable sysenter support on x86. This saves about 5k on 
> > small systems.
> 
> note that this also turns off vsyscalls. Right now vsyscalls are mostly 
> about sysenter support, but that's not fundamentally so. 4k of the 5k 
> savings come from the turn-off-vsyscalls portion.

Yes, this patch would more properly be CONFIG_VSYSCALL.

-- 
Mathematics is the supreme nostalgia of our time.
