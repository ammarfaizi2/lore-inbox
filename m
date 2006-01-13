Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422831AbWAMTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831AbWAMTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWAMTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:06:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37133 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422829AbWAMTG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:06:26 -0500
Date: Fri, 13 Jan 2006 19:06:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Dave Miller <davem@redhat.com>, Tejun Heo <htejun@gmail.com>,
       axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060113190613.GD25849@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Dave Miller <davem@redhat.com>, Tejun Heo <htejun@gmail.com>,
	axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <11371658562541-git-send-email-htejun@gmail.com> <1137167419.3365.5.camel@mulgrave> <20060113182035.GC25849@flint.arm.linux.org.uk> <1137177324.3365.67.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137177324.3365.67.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 12:35:24PM -0600, James Bottomley wrote:
> Perhaps we should take this to linux-arch ... the audience there is well
> versed in these arcane problems?

I think you need to wait for Dave Miller to reply and give a definitive
statement on how his cache coherency model is supposed to work in this
regard.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
