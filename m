Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbTCYTW1>; Tue, 25 Mar 2003 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263248AbTCYTW1>; Tue, 25 Mar 2003 14:22:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25362 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263245AbTCYTW0>;
	Tue, 25 Mar 2003 14:22:26 -0500
Date: Tue, 25 Mar 2003 11:32:56 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: per vcc data cleanups
Message-ID: <20030325193256.GF16847@kroah.com>
References: <200303251000.07690.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303251000.07690.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:00:07AM +0100, Duncan Sands wrote:
> Use struct list_head rather than a singly linked list in udsl_vcc_data.  Reject
> attempts to open multiple vccs with the same vpi/vci pair.  Some cleanups too.

Applied, thanks.

greg k-h
