Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWC1DPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWC1DPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC1DPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:15:44 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:7119 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751223AbWC1DPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:15:43 -0500
Date: Tue, 28 Mar 2006 11:44:26 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Matt Heler <lkml@lpbproductions.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Message-ID: <20060328034426.GA5474@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Matt Heler <lkml@lpbproductions.com>,
	Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
References: <20060319023413.305977000@localhost.localdomain> <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com> <200603271638.34260.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603271638.34260.lkml@lpbproductions.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 04:38:33PM -0500, Matt Heler wrote:
> We use lighttpd on our servers, and I can say with 100% that this problem 
> happens alot. Because of this , we were forced to use to userspace mechanism 
> that the lighttpd author made to cirvumvent this issue. However with this 
> patch, I'm unable to produce any of the problems we had experienced before. 
> IO-Wait has dropped significantly from 80% to 20%. 
> I'd be happy to send over some benchmarks if need be.

Thanks, your production service would be the best benchmark ;)

Would you send some performance numbers and the basic server configuration?

Wu
