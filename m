Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSIAWLg>; Sun, 1 Sep 2002 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSIAWLf>; Sun, 1 Sep 2002 18:11:35 -0400
Received: from p50887EBD.dip.t-dialin.net ([80.136.126.189]:51938 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318144AbSIAWLf>; Sun, 1 Sep 2002 18:11:35 -0400
Date: Sun, 1 Sep 2002 16:16:00 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on spinlocks
In-Reply-To: <1030918094.11553.3121.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209011615060.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1 Sep 2002, Robert Love wrote:
> 	spin_lock_irq(&lck);
> 	...
> 	spin_unlock(&lck);
> 	schedule();
> 	spin_lock_irq(&lck);
> 	...
> 	spin_unlock_irq(&lck);

That makes me understand his intention a lot more. I must have got beaten 
up by the "irqsave".

			Thunder

