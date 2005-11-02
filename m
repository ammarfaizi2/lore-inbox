Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVKBHpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVKBHpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVKBHpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:45:21 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:62684 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932616AbVKBHpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:45:20 -0500
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
From: David Woodhouse <dwmw2@infradead.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
In-Reply-To: <200511020843.01004.duncan.sands@math.u-psud.fr>
References: <4363F9B5.6010907@free.fr>
	 <200511011340.41266.duncan.sands@math.u-psud.fr>
	 <1130850242.21212.29.camel@hades.cambridge.redhat.com>
	 <200511020843.01004.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 07:45:01 +0000
Message-Id: <1130917501.10031.149.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 08:42 +0100, Duncan Sands wrote:
> we could do this for the speedtouch - in fact we used to do this: when
> someone tried to open a connection, we loaded the firmware if it
> hadn't been loaded yet.  The problem is with other modems, like the
> connexant access runner, for which you can't get all the info needed
> to create an ATM device before the firmware is loaded (the MAC address
> for example).

Don't we also have Ethernet devices like that -- where the MAC address
doesn't get set until you bring the device up?

Can we get away with changing the MAC address later? Or is there other
stuff we need earlier?

-- 
dwmw2


