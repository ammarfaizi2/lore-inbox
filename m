Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDHWvA (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTDHWu6 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:50:58 -0400
Received: from granite.he.net ([216.218.226.66]:62724 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262258AbTDHWuz (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:50:55 -0400
Date: Tue, 8 Apr 2003 16:04:42 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch] add i2c_clientname()
Message-ID: <20030408230442.GA7118@kroah.com>
References: <20030402165116.GA24766@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402165116.GA24766@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 06:51:16PM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This patch just adds a #define and a inline function to hide the
> "i2c_client->name" => "i2c_client->dev.name" move introduced by
> the recent i2c updates.  That makes it easier to build i2c drivers
> on both 2.4 and 2.5 kernels.

Thanks, I've applied this patch and will send it on soon.

greg k-h
