Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTHGQn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTHGQn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:43:59 -0400
Received: from toulouse-4-a7-62-147-202-25.dial.proxad.net ([62.147.202.25]:4482
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S270325AbTHGQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:43:56 -0400
Message-Id: <200308071644.h77Gi4xU001551@albireo.free.fr>
Date: Thu, 7 Aug 2003 18:44:04 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Fwd: Re: 2.6.0-test2: lost mouse  synchronization after apm-suspend
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 07, 2003 at 04:33:18PM +0200, frahm@irsamc.ups-tlse.fr wrote:
>> 
>> I have been testing the kernel version 2.6.0-test2 on a Dell Latitude C840. 
>> After an apm-suspend the psmouse is becoming crazy, i.e. the mouse 
>> lost synchronization and dmesg provides:
> 
> Unload all usb drivers before suspending please.
> 
> thanks,
> 
> greg k-h

I tried again without the usb-modules and the mouse is still going
crazy after an apm-suspend. Of course dmesg now only sees the error
messages concerning the mouse:
 
Suspending devices
Enabling SEP on CPU 0
Devices Resumed
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 3 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

Greetings, 

Klaus.

-- 
Klaus Frahm                             
e-mail : frahm@irsamc.ups-tlse.fr



