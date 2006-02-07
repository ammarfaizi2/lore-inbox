Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWBGJky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWBGJky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWBGJkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:40:53 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1180 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932461AbWBGJkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:40:36 -0500
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Date: Tue, 7 Feb 2006 10:39:52 +0100
User-Agent: KMail/1.8.2
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
References: <20060207105631.39a1080c.sfr@canb.auug.org.au> <20060207112713.7cd0a61c.sfr@canb.auug.org.au> <20060207.004301.35467668.davem@davemloft.net>
In-Reply-To: <20060207.004301.35467668.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071039.52490.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 09:43, David S. Miller wrote:

> 
> The alternative suggestions get less and less efficient :-) My whole
> desire is to optimize this as much as possible, without the overhead
> of an extra stack frame or "is_compat_task()" kinds of runtime tests.

My impression is you're doing a lot of ugly code here just to 
work around some pecularity of the sparc gcc. 

-Andi
