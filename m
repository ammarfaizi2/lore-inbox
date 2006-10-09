Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932975AbWJIQxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWJIQxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932977AbWJIQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:53:25 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:39953 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932975AbWJIQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:53:24 -0400
Date: Mon, 9 Oct 2006 17:53:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Timo Teras <timo.teras@solidboot.com>
Cc: drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Select only one voltage bit in OCR response
Message-ID: <20061009165317.GA6431@flint.arm.linux.org.uk>
Mail-Followup-To: Timo Teras <timo.teras@solidboot.com>,
	drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
References: <20061009150044.GB1637@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009150044.GB1637@mail.solidboot.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 06:00:44PM +0300, Timo Teras wrote:
> The card might go to inactive state (according to specification), if
> there are unsupported bits set in the OCR.

NAK.  This breaks some MMC cards.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
