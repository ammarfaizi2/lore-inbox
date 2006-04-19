Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDSN27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDSN27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWDSN27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:28:59 -0400
Received: from rtr.ca ([64.26.128.89]:60370 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750744AbWDSN26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:28:58 -0400
Message-ID: <44463B11.6030005@rtr.ca>
Date: Wed, 19 Apr 2006 09:28:49 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
       Jon Masters <jonathan@jonmasters.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] binary firmware and modules
References: <1145088656.23134.54.camel@localhost.localdomain>	 <200604181537.47183.duncan.sands@math.u-psud.fr>	 <1145370171.10255.58.camel@localhost>	 <200604181659.04657.duncan.sands@math.u-psud.fr> <1145374878.10255.69.camel@localhost>
In-Reply-To: <1145374878.10255.69.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
..
> I personally prefer full firmware names. This makes the dependency easy
> and even an end user can call modinfo and see what firmware is expected
> by a certain driver (without looking at the source code).

How does one handle the case of updated firmware from the manufacturer,
which requires *no* driver changes?  If the driver has all of the previously
known names/versions hardcoded, then would it refuse to use the new stuff?

I'm probably misunderstanding something here.
