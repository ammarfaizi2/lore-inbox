Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLAVKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLAVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:10:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60420 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264129AbTLAVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:07:47 -0500
Date: Mon, 1 Dec 2003 21:07:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pZa1x <pZa1x@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031201210739.C13621@flint.arm.linux.org.uk>
Mail-Followup-To: pZa1x <pZa1x@rogers.com>, linux-kernel@vger.kernel.org
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com> <20031129082200.A30476@flint.arm.linux.org.uk> <3FC88277.4090304@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FC88277.4090304@rogers.com>; from pZa1x@rogers.com on Sat, Nov 29, 2003 at 11:26:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 11:26:47AM +0000, pZa1x wrote:
> (a) with yenta kernel 2.6
> (b) without yenta kernel 2.6

Ok, so there aren't any differences between the PCI config space with
the module loaded and unloaded.  I guess we need to start looking at
the devices memory space registers for differences.

(This will require a little more work, so there'll be a slight delay.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
