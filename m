Return-Path: <linux-kernel-owner+w=401wt.eu-S932652AbXABAN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbXABAN6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbXABAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:13:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:50526 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932652AbXABAN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:13:57 -0500
Subject: Re: [PATCH] radeonfb: add support for newer cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20070101212551.GA19598@dreamland.darkstar.lan>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:13:35 +1100
Message-Id: <1167696815.23340.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 22:25 +0100, Luca Tettamanti wrote:
> Hi Ben, Andrew,
> I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> The patch adds support for newer Radeon cards and is mainly based on
> X.Org code.
> 
> I've fixed a few things:
> - Port sharing in radeon_get_conn_info_atom; old code didn't actually
>   deal with it leading to wrong monitor detection
> - Don't try to use I2C bus if BIOS says that there's no DDC channel,
>   otherwise bad things happen:
>   http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=116455601620186&w=2
> - Make it compile on PPC (hopefully...)
> - Cleanup whitespaces and coding style (only in the code alreay affected
>   by the patch, I didn't touched all the driver...)
> 
> Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>
> Signed-Off-By: Solomon Peachy <pizza@shaftnet.org> (I guess...)

I've done my own changes here. Can you send me a patch against Solomon's
version of the driver instead of a combined patch ?

Ben.


