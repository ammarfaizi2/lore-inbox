Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVKSVR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVKSVR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKSVR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:17:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45274 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750838AbVKSVR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:17:29 -0500
Subject: Re: Does Linux support powering down SATA drives?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511192021.40922.s0348365@sms.ed.ac.uk>
References: <437F63C1.6010507@perkel.com>
	 <200511191900.12165.s0348365@sms.ed.ac.uk>
	 <1132431907.19692.15.camel@localhost.localdomain>
	 <200511192021.40922.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 21:49:07 +0000
Message-Id: <1132436947.19692.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-19 at 20:21 +0000, Alistair John Strachan wrote:
> > Same as the problem with many household devices in standby that actually
> > end up using as lot of power in their many "turned off" hours
> 
> My mistake, I was unaware of the difference between "Suspend" and (presumably) 
> "Sleep". I've tried the latter without success on a Maxtor 120G here, does 
> this work for anybody else (hdparm -Y)?

The power consumption situation is as true for suspend as sleep. Only
pulling the plug makes that difference. At the moment the SATA layer
doesn't support hot unplugging the drive which is what is really needed.

