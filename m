Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVAJWSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVAJWSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVAJWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:17:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262589AbVAJWRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:17:04 -0500
Date: Mon, 10 Jan 2005 23:16:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>, netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] remove unused variables in net/sunrpc/auth.c
Message-ID: <20050110221651.GA29578@stusta.de>
References: <Pine.LNX.4.61.0501102239000.2987@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501102239000.2987@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:50:34PM +0100, Jesper Juhl wrote:
> 
> We have a few unused variables in net/sunrpc/auth.c:320:
> 
> net/sunrpc/auth.c:320: warning: unused variable `auth'
> net/sunrpc/auth.c:333: warning: unused variable `auth'
> net/sunrpc/auth.c:345: warning: unused variable `auth'
> net/sunrpc/auth.c:385: warning: unused variable `auth'
> 
> As far as I can see, the patch that caused them to become unused is this 
> one (which btw is ~36 months old) :
> http://linux.bkbits.net:8080/linux-2.6/diffs/net/sunrpc/auth.c@1.4?nav=index.html|src/|src/net|src/net/sunrpc|hist/net/sunrpc/auth.c
> 
> Here is a patch to get rid of them (compile tested only).
>...

Doesn't this break with CONFIG_SYSCTL=y?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

