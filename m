Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTKKVJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTKKVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:09:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:10954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263793AbTKKVJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:09:36 -0500
Date: Tue, 11 Nov 2003 13:08:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-tes9-bk15 visor causes kernel NULL pointer dereference
Message-ID: <20031111210849.GA5691@kroah.com>
References: <20031111154558.GE27685@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111154558.GE27685@charite.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 04:45:58PM +0100, Ralf Hildebrandt wrote:
> Yes, my kernel is tainted because of the nvdia module.

Can you try it without the nvidia module?

Also, can you enable debugging in the visor driver by loading it with:
	modprobe visor debug=1

and try it again and send me the kernel debug log?

thanks,

greg k-h
