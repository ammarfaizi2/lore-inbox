Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUFNSWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUFNSWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUFNSWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:22:10 -0400
Received: from hadar.amcc.com ([192.195.69.168]:64147 "EHLO hadar.amcc.com")
	by vger.kernel.org with ESMTP id S263763AbUFNSVl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:21:41 -0400
From: "Adam Radford" <aradford@amcc.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: RE: 2.6.7-rc3-mm2
Date: Mon, 14 Jun 2004 11:20:52 -0700
Organization: AMCC
X-Sent-Folder-Path: Sent Items
X-Mailer: Oracle Connector for Outlook 9.0.4 51114 (9.0.6627)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <HZB9O400.J00@hadar.amcc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 3w-xxxx.c patch is definately bogus.  It would have applied against the driver
released about a year and a half ago, however both 2.4.26 & 2.6.6 don't need this 
patch since they just printk() a warning if tw_setfeature() fails on really old
3ware controllers.

-Adam

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of William Lee
Irwin III
Sent: Monday, June 14, 2004 2:19 AM
To: Andrew Morton
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm2


On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +ignore-errors-from-tw_setfeature-in-3w-xxxxc.patch
>  3ware driver fix

I've been informed this is bogus (I myself don't understand what's going
on with this patch).


On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +fake-inquiry-for-sony-clie-peg-tj25-in-unusual_devsh.patch
>  Sony Clie USB driver fix

This unfortunately creates a duplicate entry in the unusual_devs.h

On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> +fix-thread_infoh-ignoring-__have_thread_functions.patch
>  m68k build fix

It's been suggested that the m68k people were withholding this in order
to come up with a better fix.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

