Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVATTNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVATTNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVATTNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:13:51 -0500
Received: from news.suse.de ([195.135.220.2]:46045 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261720AbVATTJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:09:28 -0500
Subject: Re: Fix ea-in-inode default ACL creation
From: Andreas Gruenbacher <agruen@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
References: <1106245344.15959.13.camel@winden.suse.de>
	 <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106248164.15959.69.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 Jan 2005 20:09:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 19:56, Valdis.Kletnieks@vt.edu wrote:
> [...] I'm failing to see how adding *another* zero operation [...] is going to help the
> fact [...]

It's an ancient kernel hackers trick:  ;)
> +		EXT3_I(inode)->i_state &= ~EXT3_STATE_NEW;

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

