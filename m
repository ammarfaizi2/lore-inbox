Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTHGQho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:37:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:3730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270354AbTHGQe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:34:56 -0400
Date: Thu, 7 Aug 2003 09:33:37 -0700
From: Greg KH <greg@kroah.com>
To: Dagfinn Ilmari =?iso-8859-1?Q?Manns=E5ker?= <ilmari@ilmari.org>
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:113 (2.6.0-test2, bluetooth)
Message-ID: <20030807163337.GD11433@kroah.com>
References: <d8ju18u2w5k.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8ju18u2w5k.fsf@wirth.ping.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:39:35AM +0200, Dagfinn Ilmari Mannsåker wrote:
> When unplugging my MSI USB Bluetooth adapter on 2.6.0-test2 I got two
> instances of the following backtrace:

{sigh, doesn't anyone read the archives anymore...}

Known issue, fixed in Linus's latest kernel tree, fix will show up in
2.6.0-test3 (if not, please let us know.)

thanks,

greg k-h
