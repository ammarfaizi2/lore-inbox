Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265680AbUFOPMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUFOPMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFOPMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:12:45 -0400
Received: from westleb.valley.net ([198.115.160.96]:61571 "EHLO
	westleb.valley.net") by vger.kernel.org with ESMTP id S265680AbUFOPMn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:12:43 -0400
Message-id: <43332297@enfield.VALLEY.NET>
Date: 15 Jun 2004 11:09:25 EDT
From: Michael.W.Salo@valley.net (Michael W. Salo)
Subject: Re: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
To: marco.roeland@xs4all.nl (Marco Roeland),
       matt@denner.demon.co.uk (Matthew Denner)
Cc: linux-kernel@vger.kernel.org
X-Mailer: BlitzMail=?ISO-8859-1?Q?=AE?= version 2.6.2/blitzserv 3.10b12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had a similar experience installing fedora on a dell laptop.
In the interest of starting "fresh" I flashed the BIOS with the latest,
installed fedora, and the laptop was dog slow
I didn't realize that by flashing the BIOS, the BIOS processor setting was
changed to "compatibility" mode,
I had to manually change to "optimum" and all was well.

just something else to check if your BIOS offers this setting...

-mike salo

--- Marco Roeland wrote:
On Tuesday June 15th 2004 Matthew Denner wrote:

> [extremely slowly functioning laptop]
> 
> Output from 'cat /proc/interrupts':
>            CPU0
>   ...
>  20:     270154   IO-APIC-level  eth0

This seems perhaps quite high? On occasion I have to use a configuration
where the network interface is configured by DHCP. When I take the
interface down (ifdown eth0) but forget to assign it its usual network
address (when changing location to another network) some interaction
with the still running DHCP client (pump) makes my laptop crawl just like
you describe. So if all other suggested options fail, you might want to
check if you maybe have such a runaway DHCP client causing havoc.
-- 
Marco Roeland
--- end of quote ---

