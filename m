Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVLNG7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVLNG7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVLNG7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:59:46 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:3477 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751285AbVLNG7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:59:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFT/RFC] sparcspkr: register with driver core as a platfrom device
Date: Wed, 14 Dec 2005 01:59:43 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200512140105.46090.dtor_core@ameritech.net> <20051213.225023.74302540.davem@davemloft.net>
In-Reply-To: <20051213.225023.74302540.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512140159.43787.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 01:50, David S. Miller wrote:
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> Date: Wed, 14 Dec 2005 01:05:45 -0500
> 
> > The following patch converts sparcspkr into a platform device,
> > putting it into sysfs hierarchy, providing parent device for input
> > device and allowing using "bind" and "unbind" driver attributes to
> > acquire and release device.
> 
> Looks fine to me.
> 

One thing that just occured to me - is there any chance of suspend working
on sparc? If not then I should probably kill sparcspkr_suspend().

-- 
Dmitry
