Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVB1N24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVB1N24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVB1N24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:28:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41486 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261587AbVB1N2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:28:55 -0500
Date: Mon, 28 Feb 2005 13:28:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: colbuse@ensisun.imag.fr
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228132849.B16460@flint.arm.linux.org.uk>
Mail-Followup-To: colbuse@ensisun.imag.fr, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
References: <1109596437.422319158044b@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1109596437.422319158044b@webmail.imag.fr>; from colbuse@ensisun.imag.fr on Mon, Feb 28, 2005 at 02:13:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 02:13:57PM +0100, colbuse@ensisun.imag.fr wrote:
> NPAR times :-). As I stated, npar is unsigned.

I think that's disgusting then - it isn't obvious what's going on, which
leads to mistakes.

For the sake of a micro-optimisation such as this, it's far more important
that the code be readable and easily understandable.

Others may disagree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
