Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTDOFXo (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTDOFXo (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:23:44 -0400
Received: from granite.he.net ([216.218.226.66]:50698 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264272AbTDOFXn (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:23:43 -0400
Date: Mon, 14 Apr 2003 22:35:39 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: discard packets for non-existant vcc's
Message-ID: <20030415053539.GB8761@kroah.com>
References: <200304121349.39418.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304121349.39418.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 01:49:39PM +0200, Duncan Sands wrote:
> I broke part of the udsl_decode_rawcell logic in a previous patch, leading to
> possible hangs on startup/shutdown.  I've attached the 2.4 and 2.5 versions.
> Thanks to Subodh Srivastava and Ted Phelps for their bug reports.  Here is the
> 2.5 patch included inline for reference:

Applied to my 2.4 and 2.5 trees, thanks.

greg k-h
