Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTD2N4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbTD2N4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:56:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31492 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262009AbTD2N4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:56:34 -0400
Date: Tue, 29 Apr 2003 15:08:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alex Williamson <alex_williamson@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250_pci include offset in iomap_base
Message-ID: <20030429150847.A13439@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex_williamson@hp.com>,
	linux-kernel@vger.kernel.org
References: <3EAD6572.8622DDC3@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EAD6572.8622DDC3@hp.com>; from alex_williamson@hp.com on Mon, Apr 28, 2003 at 11:31:30AM -0600
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 11:31:30AM -0600, Alex Williamson wrote:
>    This one-liner is required for PCI serial ports that have multiple
> MMIO ports off a single PCI BAR.  Calls to request_mem_resource() fail
> after the first one otherwise.  Patch against 2.5.67.  Thanks,

Applied.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

