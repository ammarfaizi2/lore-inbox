Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423729AbWJaTXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423729AbWJaTXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423811AbWJaTXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:23:03 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37650 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423729AbWJaTXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:23:01 -0500
Date: Tue, 31 Oct 2006 19:22:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Guillermo Marcus <marcus@ti.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
Message-ID: <20061031192252.GA26625@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Guillermo Marcus <marcus@ti.uni-mannheim.de>,
	linux-kernel@vger.kernel.org
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547733B.9040801@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:00:59PM +0100, Jiri Slaby wrote:
> Piece of code please. pci_alloc_consistent calls __get_free_pages, and there
> should be no problem with mmaping this area.

That is an implementation detail which is not portable to other
architectures.  Please don't encourage people to use non-portable
implementation details.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
