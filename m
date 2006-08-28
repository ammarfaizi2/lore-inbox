Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWH1X4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWH1X4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWH1X4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:56:18 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:13726 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964896AbWH1X4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:56:17 -0400
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <44F38BCE.2080108@flower.upol.cz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
	 <1156803102.3465.34.camel@mulgrave.il.steeleye.com>
	 <20060828230452.GA4393@powerlinux.fr>  <44F38BCE.2080108@flower.upol.cz>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 18:55:43 -0500
Message-Id: <1156809344.3465.41.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 02:35 +0200, Oleg Verych wrote:
> request_firmware() is dead also.
> YMMV, but three years, and there are still big chunks of binary in kernel.
> And please don't add new useless info _in_ it.

I er don't think so.

We (as in the Kernel) are forcing drivers on to this path.  You should
have noticed it already with the qla2xxx.  The aic94xx is the first
driver that's likely found as the boot driver for a system, that's why I
get to propose the reference implementation.

James


