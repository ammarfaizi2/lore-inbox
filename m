Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUFAPpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUFAPpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUFAPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:45:23 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:65472 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263041AbUFAPpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:45:19 -0400
Date: Tue, 1 Jun 2004 09:47:39 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: "Tvrtko A. Ur?ulin" <tvrtko.ursulin@zg.htnet.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about IDE disk shutdown
Message-ID: <20040601154739.GA17208@bounceswoosh.org>
Mail-Followup-To: "Tvrtko A. Ur?ulin" <tvrtko.ursulin@zg.htnet.hr>,
	linux-kernel@vger.kernel.org
References: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <200406011713.59904.tvrtko.ursulin@zg.htnet.hr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun  1 at 17:13, Tvrtko A. Ur?ulin wrote:
>According to my hard disk manual, it is absolutely recommended to put the 
>drive in STANDBY or SLEEP mode before power cut-off because in that way heads 
>are nicely parked. In that way it is guaranteed to have 300000 head 
>load/unload cycles minimum, while in other case it is just 20000 cycles.

All "modern" drives have plenty of back-EMF to park the heads properly
when power fails.

Remember that even if you are limited to 20,000 power cycles reliably,
that's over 5 reboots every day for 10 years, well over the expected
lifetime of the drive. (unless you run windows yuk yuk)


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

