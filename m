Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWADR1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWADR1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWADR1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:27:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14606 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965160AbWADR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:27:17 -0500
Date: Wed, 4 Jan 2006 17:27:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: platform_device_add_resources doesn't request the resources?
Message-ID: <20060104172712.GA3119@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@gate.crashing.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0601041104560.32358-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0601041104560.32358-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:07:51AM -0600, Kumar Gala wrote:
> Is there any reason that platform_device_add_resources doesn't process the 
> resources that are passed to it like platform_device_add does?

Yes.  Please dig out the example usage in the change comments which
introduced it.  The use is clearly explained in there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
