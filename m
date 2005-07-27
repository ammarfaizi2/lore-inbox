Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVG0UtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVG0UtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVG0Urb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:47:31 -0400
Received: from waste.org ([216.27.176.166]:10940 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262433AbVG0Uqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:46:42 -0400
Date: Wed, 27 Jul 2005 13:46:22 -0700
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
Message-ID: <20050727204622.GI12006@waste.org>
References: <20050726235824.GN12006@waste.org> <20050726.170349.10935659.davem@davemloft.net> <20050727023636.GP12006@waste.org> <20050727.131900.59654701.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727.131900.59654701.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 01:19:00PM -0700, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Tue, 26 Jul 2005 19:36:37 -0700
> 
> > # HG changeset patch
> > # User mpm@selenic.com
> > # Node ID 6cdd6f36d53678a016cfbf5ce667cbd91504d538
> > # Parent  75716ae25f9d87ee2a5ef7c4df2d8f86e0f3f762
> > Move in_aton from net/ipv4/utils.c to net/core/utils.c
> 
> This patch doesn't apply, in the current 2.6.x GIT tree
> NETCONSOLE does not depend on NETDEVICES.

Odd, gitweb of Linus' tree seems to disagree. I see it depends on
NETDEVICES && INET && EXPERIMENTAL. NETDEVICES has been there since
the beginning of git history and according to my Mercurial import from
BKCVS, it's been dependent on NETDEVICES since I first submitted it.

-- 
Mathematics is the supreme nostalgia of our time.
