Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUHDRas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUHDRas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUHDRas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:30:48 -0400
Received: from blacksun.leftmind.net ([204.225.93.62]:32016 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id S267362AbUHDRar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:30:47 -0400
Date: Wed, 4 Aug 2004 13:30:46 -0400
From: Anthony de Boer <linux-kernel@lists.leftmind.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configure IDE probe delays
Message-ID: <20040804133046.X23495@leftmind.net>
References: <1091309723.1677.391.camel@mindpipe> <410C12CA.7060109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410C12CA.7060109@pobox.com>; from jgarzik@pobox.com on Sat, Jul 31, 2004 at 05:44:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Broken hardware will always exist.  Sounds like you want 
> CONFIG_PERFECT_WORLD ?

You've already got #ifndef I_WISH_WORLD_WERE_PERFECT in net/ipv4/ip_gre.c
and ipip.c, and should likely maintain compatibility with what's already
there.

-- 
Anthony de Boer
