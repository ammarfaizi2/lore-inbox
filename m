Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWHDSew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWHDSew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHDSew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:34:52 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:32162 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751413AbWHDSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:34:51 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Stability-Problem of EHCI with a larger number of USB-Hubs/Devices
Date: Fri, 4 Aug 2006 11:08:18 -0700
User-Agent: KMail/1.7.1
Cc: Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
References: <44C126C3.9000105@citd.de>
In-Reply-To: <44C126C3.9000105@citd.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041108.19549.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try with 2.6.18-rc3?  There's a Kconfig option for an
improved interrupt scheduler, which might help especially with
all those low speed devices.

- Dave

