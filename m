Return-Path: <linux-kernel-owner+w=401wt.eu-S1751329AbXAFJuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbXAFJuf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 04:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFJuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 04:50:35 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:42117 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXAFJue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 04:50:34 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Leonard Norrgard <leonard.norrgard@refactor.fi>
Subject: Re: 2.6.20-rc3: bt878/bttv: Unknown symbols, despite being defined in module depended on
Date: Sat, 6 Jan 2007 10:16:47 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <459A3DCD.4020701@refactor.fi>
In-Reply-To: <459A3DCD.4020701@refactor.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061016.48397.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2 January 2007 12:11, Leonard Norrgard wrote:
> This seems a bit odd. As the bt878 module loads, I get the following
> error messages, despite definitions in the bttv module that bt878
> depends on:
> 
> # egrep '(bttv_read_gpio|bttv_write_gpio|bttv_gpio_enable)' /var/log/dmesg
> bt878: Unknown symbol bttv_read_gpio
> bt878: Unknown symbol bttv_write_gpio
> bt878: Unknown symbol bttv_gpio_enable

This may be related to MODULE_FORCE_UNLOAD=y.

Best wishes,

Duncan.
