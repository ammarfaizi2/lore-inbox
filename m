Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUG2Mvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUG2Mvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUG2Mvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:51:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:50402 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264526AbUG2MvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:51:01 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ncunningham@linuxmail.org
Subject: Re: fixing usb suspend/resuming
Date: Thu, 29 Jul 2004 14:51:05 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <20040729083543.GG21889@openzaurus.ucw.cz> <1091103438.2703.13.camel@desktop.cunninghams>
In-Reply-To: <1091103438.2703.13.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407291451.05630.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Regarding the spinning down before suspending to disk, I have a patch in
> my version that adds support for excluding part of the device tree when
> calling drivers_suspend. I take the bdevs we're writing the image to,
> trace the structures to get the relevant device tree entry/ies and then
> move (in the correct order) those devices and their parents from the
> active devices list to a 'dont' touch' list (I don't call it that in

How do you deal with md, loop, etc... ?

	Regards
		Oliver
