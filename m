Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKBSTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKBSTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKBSTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:19:03 -0500
Received: from hentges.net ([81.169.178.128]:24760 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S261296AbUKBSSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:18:05 -0500
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
From: Matthias Hentges <mailinglisten@hentges.net>
To: Len Brown <len.brown@intel.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1099377976.13831.195.camel@d845pe>
References: <1099336966.4174.6.camel@mhcln03>
	 <1099377976.13831.195.camel@d845pe>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 19:18:02 +0100
Message-Id: <1099419482.4687.5.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Len,

Am Dienstag, den 02.11.2004, 01:46 -0500 schrieb Len Brown:

[...]

> With the unmodified -mm2 tree, please build with CONFIG_PNPACPI=n
> and give that a go.

Setting CONFIG_PNPACPI=n ( which can be found in drivers/pnp btw, for
all those reading this thread ) indeed fixes the problem.

As does applying your remove_driver.patch ( with CONFIG_PNPACPI=y) from
the other other thread.

Both work-arounds  also fix the asus_acpi kernel module which either
wouldn't load at all (no such device) or would load but do nothing
(empty /p/a/asus).

HTH

-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

