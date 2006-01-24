Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWAXUkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWAXUkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 15:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWAXUkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 15:40:12 -0500
Received: from [198.99.130.12] ([198.99.130.12]:63633 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965002AbWAXUkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 15:40:10 -0500
Date: Tue, 24 Jan 2006 16:31:41 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml: enable drivers (input, fb, vt)
Message-ID: <20060124213141.GA7891@ccure.user-mode-linux.org>
References: <43D64F05.90302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D64F05.90302@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 05:00:05PM +0100, Gerd Hoffmann wrote:
> This patch enables a number of drivers for the uml build, in preparation
> for the uml framebuffer driver patch coming next ;)

I'm still unsure about this.  It builds now, which is an improvement, but
doesn't seem to work for me.

Displaying it remotely just doesn't work for me.  I get "uml-x11-fb:
can't open X11 window" in the kernel log.

Locally, it creates a window, and boots, but there's no output in the
window, and there's no sign of a getty on the main console when I log
in through another console.

				Jeff
