Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVCKVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVCKVEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVCKVEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:04:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61837 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261766AbVCKVA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:00:59 -0500
Date: Fri, 11 Mar 2005 14:00:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, LKML <linux-kernel@vger.kernel.org>,
       Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] MPC52xx updates : sparse clean-ups
Message-ID: <20050311210052.GC3098@smtp.west.cox.net>
References: <4231F9F9.5080506@246tNt.com> <be4da82f8d12e20b54050e15fd27df36@freescale.com> <423203EC.1070003@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423203EC.1070003@246tNt.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 09:47:40PM +0100, Sylvain Munaut wrote:

[snip]
> static struct hw_interrupt_type mpc52xx_ic = {
> -       "MPC52xx",
[snip]
> +       .typename       = "MPC52xx",

Shouldn't that be "  MPC52xx  ", or is that another field I'm thinking
of?

-- 
Tom Rini
http://gate.crashing.org/~trini/
