Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbTCLBCr>; Tue, 11 Mar 2003 20:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbTCLBCr>; Tue, 11 Mar 2003 20:02:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57862 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262994AbTCLBCr>;
	Tue, 11 Mar 2003 20:02:47 -0500
Date: Tue, 11 Mar 2003 17:02:45 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: send path optimization
Message-ID: <20030312010244.GB20821@kroah.com>
References: <200303101038.52069.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303101038.52069.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 10:38:52AM +0100, Duncan Sands wrote:
> Write multiple cells in one function call, rather than one cell per
> function call.  Under maximum send load, this reduces cell writing
> CPU usage from 0.0095% to 0.0085% on my machine.  A 10% improvement! :)

Applied, thanks.

greg k-h
