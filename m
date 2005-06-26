Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVFZSBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVFZSBB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFZSBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:01:01 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57030 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261523AbVFZSAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:00:20 -0400
Subject: Re: [PATCH] I2O: Lindent run and replacement of printk through osm
	printing functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <42BC93EC.8030909@shadowconnect.com>
References: <200506241709.j5OH98vv000983@hera.kernel.org>
	 <42BC888E.3010600@pobox.com>  <42BC93EC.8030909@shadowconnect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119808648.28644.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 18:57:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-06-25 at 00:14, Markus Lidel wrote:
> > Also, you typically want to do a pass through the post-Lindent code, to 
> > fix crazy word-wrapped lines like
> >>                  if (copy_from_user

No need. Just don't use Lindent or hack the lindent script to pass a
more sane line length. See man indent.


