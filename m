Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270117AbTGMFOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 01:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270119AbTGMFOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 01:14:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:63711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270117AbTGMFOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 01:14:50 -0400
Date: Sat, 12 Jul 2003 22:29:16 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: smiler@lanil.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: [2.7.75] Misc compiler warnings
Message-ID: <20030713052916.GA1101@kroah.com>
References: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu> <1058055803.12256.27.camel@sm-wks1.lan.irkk.nu> <20030713040801.GA2695@kroah.com> <20030712215058.16f76ebc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712215058.16f76ebc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 09:50:58PM -0700, Andrew Morton wrote:
> 
> Better would be just to not play around with dev_t's in-kernel in this
> manner at all.  Why are we doing it?

To export to userspace the dev_t assigned to a device.  I should just
make a single function for this, but haven't gotten arround to it yet.

I'll fix these up to remove the warnings.

thanks,

greg k-h
