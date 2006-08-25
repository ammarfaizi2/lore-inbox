Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWHYNjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHYNjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWHYNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:39:44 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:21267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932138AbWHYNjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:39:43 -0400
Date: Fri, 25 Aug 2006 14:39:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Bernatik <jan.bernatik@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: platform device / driver question
Message-ID: <20060825133933.GC2287@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Bernatik <jan.bernatik@gmail.com>,
	linux-kernel@vger.kernel.org
References: <dca824fc0608250608s3b371291qd313986cffc1e028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca824fc0608250608s3b371291qd313986cffc1e028@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:08:51PM +0200, Jan Bernatik wrote:
> I studied smc91x driver to understand how platform driver / device
> subsystem works. On #kernelnewbies channel I was told this driver is
> "hopelessly broken". How should one create and register the
> platform_device/driver ? Is the implementation in smc91x correct ?

That's probably from some ill-informed person.  As far as I'm aware,
the driver works perfectly and uses the driver model correctly.

There are some aspects of the driver which are less good (such as all
the machine specific configuration gunk in smc91x.h) but apart from
that, it's fine.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
