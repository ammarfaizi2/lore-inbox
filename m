Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946604AbWKJNSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946604AbWKJNSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946600AbWKJNSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:18:50 -0500
Received: from smtpout.mac.com ([17.250.248.171]:15055 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1946604AbWKJNSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:18:49 -0500
In-Reply-To: <20061109231533.GE2616@elf.ucw.cz>
References: <20061108175412.3c2be30c.holzheu@de.ibm.com> <20061109231533.GE2616@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6F3F24CD-2893-43E2-A006-F809E35607AE@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How to document dimension units for virtual files?
Date: Fri, 10 Nov 2006 08:18:31 -0500
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 09, 2006, at 18:15:33, Pavel Machek wrote:
> Anyway, Greg's opinion was that we should just document units in  
> documentation and not pollute names with that. I'm not sure if it  
> works for battery (because of current:mA vs. current:mW confusion).

Well, IMO you should never have "current:mW" in any form whatsoever  
anyways.  Electrically it makes no sense; it's like saying  
"height:grams".  Watts are an indication of power emitted or consumed  
per unit time (as opposed to current/amperage which counts only the  
number of electrons and not the change in energy), so perhaps  
"power_flow:mW" or "power_consumption:mW" would make more sense?

I can conceivably see a need for a "current:mJ_per_s" versus  
"current:mW" depending on the hardware-reported units, but never both  
at the same time.

Cheers,
Kyle Moffett

