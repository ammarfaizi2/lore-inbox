Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbULYOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbULYOEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 09:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbULYOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 09:04:04 -0500
Received: from coderock.org ([193.77.147.115]:44251 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261510AbULYOEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 09:04:01 -0500
Date: Sat, 25 Dec 2004 15:04:06 +0100
From: Domen Puncer <domen@coderock.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: delete unused file
Message-ID: <20041225140405.GA3768@masina.coderock.org>
References: <20041225134127.EE9D64DC08C@golobica.uni-mb.si> <20041225135502.GY771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225135502.GY771@holomorphy.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/04 05:55 -0800, William Lee Irwin III wrote:
> On Sat, Dec 25, 2004 at 02:41:37PM +0100, domen@coderock.org wrote:
> > Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> include/asm-alpha/numnodes.h is included by include/linux/numa.h when
> CONFIG_NUMA is set. grepping for the filename can be fooled.

Damn, it shouldn't miss it, i'll check my scripts before sending more
patches like this.

Thanks wli.


> 
> 
> -- wli
