Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVAGP6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVAGP6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVAGP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:58:41 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:3026 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261476AbVAGP6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:58:03 -0500
Message-ID: <41DEB1DB.30004@schiggl.de>
Date: Fri, 07 Jan 2005 16:59:23 +0100
From: Lion Vollnhals <webmaster@schiggl.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041220)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
References: <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org> <20050104214315.GB1520@elf.ucw.cz> <41DC0E70.4000005@schiggl.de> <20050106222927.GC25913@elf.ucw.cz>
In-Reply-To: <20050106222927.GC25913@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>I have a problem with net-devices, ne2000 in particular, in 2.6.9 and 
>>2.6.10, too. After a resume the ne2000-device doesn't work anymore. I 
>>have to restart it using the initscripts.
>>
>>How do I add suspend/resume support (to ISA devices, like my ne2000)?
>>Can you point me to some information/tutorial?
> 
> 
> Look how i8042 suspend/resume support is done and do it in similar
> way...
> 									Pavel

thx, i will do that.

--
Lion Vollhals
