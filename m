Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVAZND6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVAZND6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVAZND5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:03:57 -0500
Received: from colino.net ([213.41.131.56]:3312 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262287AbVAZNDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:03:50 -0500
Date: Wed, 26 Jan 2005 14:03:19 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: Jorge Bernal <koke@amedias.org>
Subject: Re: [PATCH] therm_adt746x: smooth fan
Message-ID: <20050126140319.05d7264b@pirandello>
X-Mailer: Sylpheed-Claws 1.0.0cvs13.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
References: <200501260912.27216.koke@amedias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patchs allows a smoother fan speed switching with therm_adt746x.
> Instead of setting 0 or 128, it scales speed according to temperature.

Thanks, but you'd have saved some of your time if you had checked
2.6.10: I implemented such a system, it's in since 2.6.10 :)

> It would be even better if I'd have more precise temp data, but I'm
> not sure if it's even supported by the chip.

It's not possible, iirc.

Also, it's better to Cc: the maintainer of a module when submitting
patches. I'm not subscribed to lkml currently, and would have missed
your mail if I didn't get it from a friend.
-- 
Colin
