Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVGTO4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVGTO4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVGTOxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:53:44 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:52960 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261357AbVGTOwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:52:47 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: karim@opersys.com
Subject: Re: Weird USB errors on HD
Date: Wed, 20 Jul 2005 15:53:09 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <42DD2EA4.5040507@opersys.com>
In-Reply-To: <42DD2EA4.5040507@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201553.09602.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jul 2005 17:47, Karim Yaghmour wrote:
> I have a usb-attached HD that I use from time to time. When it's connected
> to my desktop through a hub it works flawlessly. When connected to my Dell
> D600 Laptop, however, it sometimes randomly exhibits a loud click (as if
> the heads went berzerk) and the device goes unrecognized (i.e. the USB
> layer drops the device and then redetects it again; meanwhile there is FS
> corruption.)

I've noticed my laptop is less able to output the required current for my 
portable HD than my desktop; either way it's probably not a good idea 
exceeding the USB specifications for current output @ 5V, so I'd recommend 
you use a powered hub or external PSU (if the HD supports one).

Also a (slightly) nasty but functional trick is to have the power in when the 
HD initially spins up, then remove the power. Once the drive has spun up it 
seems to use a lot less power.

You can get special USB cables that link two USB ports' 5Vs together in 
parallel, which seems to help supply the necessary current; after the HD has 
spun up you can remove the second "dummy" USB connector (my laptop only has 
two USB ports and I require the second port).

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
