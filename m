Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263248AbTCYTXM>; Tue, 25 Mar 2003 14:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263259AbTCYTXM>; Tue, 25 Mar 2003 14:23:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26130 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263248AbTCYTWg>;
	Tue, 25 Mar 2003 14:22:36 -0500
Date: Tue, 25 Mar 2003 11:33:07 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: eliminate ATM open/close races
Message-ID: <20030325193307.GG16847@kroah.com>
References: <200303251031.50691.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303251031.50691.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:31:50AM +0100, Duncan Sands wrote:
> The list of open vccs is modified by open/close, and traversed by the
> receive tasklet.  This is the last race I know of in this driver.

Applied, thanks.

greg k-h
