Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWG2Tqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWG2Tqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWG2Tqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:46:39 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:13251 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752075AbWG2Tqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:46:38 -0400
Date: Sat, 29 Jul 2006 21:46:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060729194625.GA10459@mars.ravnborg.org>
References: <20060418234156.GA28346@apogee.jonmasters.org> <35fb2e590607291206o2c25d3el704942e77ca98f62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590607291206o2c25d3el704942e77ca98f62@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 08:06:14PM +0100, Jon Masters wrote:
> ---------- Forwarded message ----------
> From: Jon Masters <jonathan@jonmasters.org>
> Date: Apr 19, 2006 12:41 AM
> Subject: [PATCH] MODULE_FIRMWARE for binary firmware(s)
> To: akpm@osdl.org, linux-kernel@vger.kernel.org
> 
> 
> From: Jon Masters <jcm@redhat.com>
> 
> Right now, various kernel modules are being migrated over to use
> request_firmware in order to pull in binary firmware blobs from userland
> when the module is loaded. This makes sense.
> 
> However, there is right now little mechanism in place to automatically
> determine which binary firmware blobs must be included with a kernel in
> order to satisfy the prerequisites of these drivers. This affects
> vendors, but also regular users to a certain extent too.
> 
> The attached patch introduces MODULE_FIRMWARE as a mechanism for
> advertising that a particular firmware file is to be loaded - it will
> then show up via modinfo and could be used e.g. when packaging a kernel.
NAK.
Please provide some inline documentation so users knows how it is
supposed to be used etc. See MODULE_VERSION as an example.
Changelog comments is not enough documentation.

	Sam
