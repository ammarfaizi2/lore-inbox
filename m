Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUC3WCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUC3WCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:02:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:7578 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261422AbUC3WB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:01:59 -0500
Date: Tue, 30 Mar 2004 13:56:14 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] datafab fix and unusual devices
Message-ID: <20040330215614.GF11605@kroah.com>
References: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 12:44:09AM +0200, Andries.Brouwer@cwi.nl wrote:
> datafab.c has an often-seen bug: the SCSI READ_CAPACITY command
> does not need the number of sectors but the last sector.

Applied, thanks.

greg k-h
