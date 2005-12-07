Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVLGPu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVLGPu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLGPu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:50:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751155AbVLGPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:50:56 -0500
Date: Wed, 7 Dec 2005 15:50:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207155034.GB6793@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY103-F1629FE16D5F4DBB7B16524DF430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F1629FE16D5F4DBB7B16524DF430@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:44:29AM -0600, Jason Dravet wrote:
> So I ask this mailing list Can the kernel detect the proper number of 
> serial ports or not?

It does detect serial ports found in the machine.

However, it _always_ offers the configured number of serial devices.
This is to allow folk whose ports are not autodetected to configure
them appropriately via the setserial command.  If they were not
available, they could not configure them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
