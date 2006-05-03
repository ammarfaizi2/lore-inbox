Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWECQrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWECQrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWECQrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:47:00 -0400
Received: from rtr.ca ([64.26.128.89]:23231 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030248AbWECQq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:46:59 -0400
Message-ID: <4458DE81.6040603@rtr.ca>
Date: Wed, 03 May 2006 12:46:57 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: sander@humilis.net
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com> <20060503121643.GA21882@favonius> <4458A52D.30100@rtr.ca> <20060503133239.GA11811@favonius>
In-Reply-To: <20060503133239.GA11811@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
>
> The message "PCI ERROR; PCI IRQ cause=0x40000100" gives no result in
> Google. Could this be a broken or miss-seated controller?

Yes.  Those bits mean: "no target response within 4 PCI clock cycles".

In English, I believe the translation is "dead/disconnected controller".

Cheers
