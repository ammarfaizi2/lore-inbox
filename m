Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVC1Iuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVC1Iuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 03:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVC1Iuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 03:50:54 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:55786 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261358AbVC1Iut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 03:50:49 -0500
Date: Mon, 28 Mar 2005 00:49:53 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       from-linux-kernel@I-love.sakura.ne.jp
Subject: Re: Off-by-one bug at unix_mkname ?
Message-ID: <20050328084953.GA3712@taniwha.stupidest.org>
References: <200503281700.HHE91205.FtVLOStGOSPMYJFMN@I-love.sakura.ne.jp> <20050328.172108.30349253.yoshfuji@linux-ipv6.org> <20050328.173938.26746686.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328.173938.26746686.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 05:39:38PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:

> +		/*
> +		 *	This may look like an off by one error but it is
> +		 *	a bit more subtle. 108 is the longest valid AF_UNIX
> +		 *	path for a binding. sun_path[108] doesnt as such
> +		 *	exist. However in kernel space we are guaranteed that
> +		 *	it is a valid memory location in our kernel
> +		 *	address buffer.

icky pointless white space?

> +		 */
> +		if (len > sizeof(*sunaddr))

what?
