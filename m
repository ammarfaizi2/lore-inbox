Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWCTQtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWCTQtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965879AbWCTQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:49:19 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:43908 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965203AbWCTQtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:49:18 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Dave Miller <davem@redhat.com>, axboe@suse.de, bzolnier@gmail.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <441EDB0B.3050805@gmail.com>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
	 <1142871172.3283.17.camel@mulgrave.il.steeleye.com>
	 <441ED79B.4000009@gmail.com>
	 <1142872412.3283.24.camel@mulgrave.il.steeleye.com>
	 <441EDB0B.3050805@gmail.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:48:54 -0600
Message-Id: <1142873334.3283.26.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 01:40 +0900, Tejun Heo wrote:
> Hmmm... if fixing is too much work, how about adding WARN_ON() or one of
> its friends if we enter flush_dcache_page() from atomic context?

Suits me ... if it ever triggers someone else can look at fixing it ...

James


