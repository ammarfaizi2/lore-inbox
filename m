Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWFAPx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWFAPx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWFAPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:53:28 -0400
Received: from mail1.kontent.de ([81.88.34.36]:58815 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1030211AbWFAPx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:53:27 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Date: Thu, 1 Jun 2006 17:53:37 +0200
User-Agent: KMail/1.8
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrew Morton" <akpm@osdl.org>,
       "David Liontooth" <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org> <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011753.38157.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. Juni 2006 17:09 schrieb linux-os (Dick Johnson):
> Many, most, perhaps all such devices don't take more power when they
> are "enabled". Everything is already running and sucking up maximum
> current when you plug it in! If the motherboard didn't smoke when

If they do, they are violating the spec. A device in the unconfigured (state 0)
state must not draw more than 100mA.

	Regards
		Oliver
