Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268378AbTAMWdk>; Mon, 13 Jan 2003 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbTAMWde>; Mon, 13 Jan 2003 17:33:34 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8419 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268378AbTAMWbm>;
	Mon, 13 Jan 2003 17:31:42 -0500
Date: Mon, 13 Jan 2003 17:40:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.5.57 missing isapnp_card_protocol
Message-ID: <20030113224028.GB13531@gtf.org>
References: <200301132209.OAA02162@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301132209.OAA02162@adam.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 02:09:49PM -0800, Adam J. Richter wrote:
> 	Linux-2.5.57 deletes the definition of isapnp_card_protocol
> and then adds some references to it.  So, the kernel does not link
> if you have enabled ISA PnP support.  I'm not sure whether
> isapnp_card_protocol is supposed to be removed or not.

That's the fault of some random driver that hasn't been updated to the
new isapnp API yet...

