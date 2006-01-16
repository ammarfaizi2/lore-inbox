Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWAPXUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWAPXUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAPXUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:20:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:32431 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751272AbWAPXUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:20:07 -0500
Subject: Re: Input: HID - add support for fn key on Apple PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060116103341.GA4809@suse.de>
References: <200601141910.k0EJAm65013553@hera.kernel.org>
	 <20060116103341.GA4809@suse.de>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:19:48 +1100
Message-Id: <1137453588.4823.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 11:33 +0100, Olaf Hering wrote:

> Should this depend on CONFIG_$powerbook?

Except that there is no such thing :) there is the CONFIG_PMAC_PBOOK
thing but that will be going away soon as it's over abused.

You may want to make it CONFIG_PPC_PMAC if you want, but it doesn't
really matter as the option will not cause any problem on non-powerbook
and it will still build. Beside, who knows, it might even end up being
useful on the Intel Macs if Linux ever runs on them :)

Ben.


