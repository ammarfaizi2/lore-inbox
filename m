Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWEVNNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWEVNNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWEVNNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:13:17 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:46642 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750814AbWEVNNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:13:16 -0400
X-ME-UUID: 20060522131315839.CD0151C001DC@mwinf0807.wanadoo.fr
Subject: Re: APIC error on CPUx
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andi Kleen <ak@suse.de>
Cc: Vladimir Dvorak <dvorakv@vdsoft.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200605221454.05874.ak@suse.de>
References: <44716A5F.3070208@vdsoft.org> <200605221403.16464.ak@suse.de>
	 <4471AC63.8060406@vdsoft.org>  <200605221454.05874.ak@suse.de>
Content-Type: text/plain
Message-Id: <1148303583.26628.167.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 22 May 2006 15:13:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 14:54, Andi Kleen wrote:
> > Can "noapic" or "nolapic" solve this ? Does it mean ( with these
> > parameters ) that devices will start to use 8259 interrupt controller
> > instead APIC ?
> 
> nolapic won't work on SMP (or rather forced UP mode) 
> 
> You'll not see the messages anymore, but might get silent corruption.
> Or it might work around it because it will make everything a bit slower.
> 
> > 
> > Is harmfull put "noapic" on "nolapic" to cmdline ?
> 
> If all devices can still be accessed noapic is just slower.

So, is there a software solution to this problem ?
I have the same one on an old Dell server.

Thanks,
	Xav


