Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270531AbUJTUYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270531AbUJTUYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270558AbUJTUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:20:55 -0400
Received: from mail1.kontent.de ([81.88.34.36]:48805 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270525AbUJTUQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:16:07 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Tomas Carnecky <tom@dbservice.com>
Subject: Re: my opinion about VGA devices
Date: Wed, 20 Oct 2004 22:16:35 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org> <41765A8C.2020309@dbservice.com>
In-Reply-To: <41765A8C.2020309@dbservice.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410202216.35464.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I guess that you are talking about the fact that displaying text 
> messages would be possible only after the first device driver has 
> initialized and registered with the kernel.

No, the kernel cannot print at all.
 
> You could do the printing in two stages: at the begining the same way as 
> in the current kernel, but as soon as the first driver is registered, 
> the kernel switches to the function provided by the driver.

The current kernel can print only if the video chipset is initialised
to a certain degree, which usually the firmware or the boot loader
provide for.

	Regards
		Oliver
