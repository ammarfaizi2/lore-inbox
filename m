Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVAJSf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVAJSf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVAJSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:24:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5304 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262411AbVAJSKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:10:22 -0500
Date: Mon, 10 Jan 2005 10:10:16 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [announce] 2.6.10-bk13-kj
Message-ID: <20050110181016.GD3099@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep-drivers_scsi_imm.patch

This patch should be dropped. The msleep() call will ignore waitqueue events
set up by prepare_to_wait().

Thanks,
Nish
