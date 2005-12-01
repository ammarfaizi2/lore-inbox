Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVLAQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLAQOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVLAQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:14:22 -0500
Received: from khc.piap.pl ([195.187.100.11]:7940 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932305AbVLAQOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:14:21 -0500
To: Duncan Sands <duncan.sands@free.fr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
	<200512010859.19905.duncan.sands@free.fr>
	<m3u0ds7so0.fsf@defiant.localdomain>
	<200512011619.53339.duncan.sands@free.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 01 Dec 2005 17:14:19 +0100
In-Reply-To: <200512011619.53339.duncan.sands@free.fr> (Duncan Sands's
 message of "Thu, 1 Dec 2005 16:19:52 +0100")
Message-ID: <m3d5kg7q1w.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <duncan.sands@free.fr> writes:

>> Do the speedtouches have some means (firmware) for debugging or logging?
>> We would need to see what does the ADSL receive and what does it think
>> about it.
>
> I don't even have any specs...

"strings" on the fw binary shows there is some debugger (SACHEM-LT and
possibly more things). It probably needs some terminal interface,
there might be some diagnostic port (usually TTL-level RS232) on board
or (in this case almost certainly) it's created over USB.

It would require some amount of work, not sure if it's worth it.
-- 
Krzysztof Halasa
