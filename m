Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWFNVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWFNVjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWFNVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:39:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:63458 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932373AbWFNVjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:39:09 -0400
Date: Tue, 13 Jun 2006 22:22:24 -0700
From: Greg KH <greg@kroah.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect speed at Palm 100 serial adapter
Message-ID: <20060614052224.GA19140@kroah.com>
References: <20060612112309.GA14262@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612112309.GA14262@kestrel.barix.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 01:23:09PM +0200, Karel Kulhavy wrote:
> Hello
> 
> If I set 57600 speed on Palm 100 USB/serial adapter (USB IDs 0x830, 0x80),
> the speed is according to oscilloscope at 19200, but the tcsetattr
> doesn't fail and subsequent tcgetattr returns 115200.
> 
> If the hardware supports it, the speed should be set to 115200. If it
> doesn't, tcgetattr should then indicate 19200.
> 
> Linux kernel is 2.6.16.19.

Please send a patch to us for this, as this driver was reverse
engineered by watching the data stream and might be wrong in places.

thanks,

greg k-h
