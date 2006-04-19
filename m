Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDSNhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDSNhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDSNhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:37:20 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9414 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750761AbWDSNhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:37:19 -0400
Subject: Re: [RFC] binary firmware and modules
From: Marcel Holtmann <marcel@holtmann.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
       Jon Masters <jonathan@jonmasters.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44463B11.6030005@rtr.ca>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604181537.47183.duncan.sands@math.u-psud.fr>
	 <1145370171.10255.58.camel@localhost>
	 <200604181659.04657.duncan.sands@math.u-psud.fr>
	 <1145374878.10255.69.camel@localhost>  <44463B11.6030005@rtr.ca>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 15:37:22 +0200
Message-Id: <1145453842.3564.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> > I personally prefer full firmware names. This makes the dependency easy
> > and even an end user can call modinfo and see what firmware is expected
> > by a certain driver (without looking at the source code).
> 
> How does one handle the case of updated firmware from the manufacturer,
> which requires *no* driver changes?  If the driver has all of the previously
> known names/versions hardcoded, then would it refuse to use the new stuff?

if no driver change is needed, then you simply can replace the firmware
file and reload the driver. With the BlueFRITZ! USB driver we did this a
bunch of times and it worked out perfectly. The firmware name in this
case is only a placeholder.

Regards

Marcel


