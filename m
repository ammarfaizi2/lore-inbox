Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270023AbUJNKbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270023AbUJNKbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270024AbUJNKbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:31:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270023AbUJNKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:30:59 -0400
Date: Thu, 14 Oct 2004 11:30:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Hirokazu Takata <takata.hirokazu@renesas.com>, jgarzik@pobox.com,
       takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       paul.mundt@nokia.com, nico@cam.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
Message-ID: <20041014113044.A5076@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Hirokazu Takata <takata.hirokazu@renesas.com>, jgarzik@pobox.com,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	paul.mundt@nokia.com, nico@cam.org, netdev@oss.sgi.com
References: <416BFD79.1010306@pobox.com> <20041013.105243.511706221.takata.hirokazu@renesas.com> <416C8E0B.4030409@pobox.com> <20041013.121547.863739114.takata.hirokazu@renesas.com> <20041012223227.45a62301.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041012223227.45a62301.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 12, 2004 at 10:32:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:32:27PM -0700, Andrew Morton wrote:
> smc91x-assorted-minor-cleanups.patch

This patch removes a comment I added to satisfy Jeff's review which
explains how the link state is initialised - it probably isn't a good
idea to remove this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
