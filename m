Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVKFRuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVKFRuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKFRuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:50:10 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47414 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932240AbVKFRuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:50:09 -0500
Date: Sun, 06 Nov 2005 11:50:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Whys and hows of initrds
In-reply-to: <55Wvl-4jY-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <436E424D.7040909@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <55Wvl-4jY-27@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grfgguvf@gmail.com wrote:
> Hi,
> I don't know if the LKML is a technical kernel development list or a
> newbie support list (or both?) so maybe I'm posting to the wrong
> place.

You likely are.. and this is also quite distribution specific so a 
distribution support forum would likely be a better place to ask.

Whether or not you need an initrd depends on whether or not drivers 
needed to mount the root filesystem are compiled as modules or built 
into the kernel. If they are all built in then you shouldn't really need 
an initrd. However distributions usually use it so that the kernel can 
be the same for all systems and simply load the correct modules.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

