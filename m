Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHOLCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275903AbTHOLCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:02:18 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:16913 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262439AbTHOLCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:02:17 -0400
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <00a501c3631c$676237b0$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Paul Nasrat" <pauln@truemesh.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <003701c3630f$387a6330$401a71c3@izidor> <20030815103529.GQ13037@shitake.truemesh.com>
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem
Date: Fri, 15 Aug 2003 13:00:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using the new drivers for XFree86 and if the touchpad is visible
in dmesg, than it is working in XFree86 too. When it isn't,
it isn't than listed in /proc/bus/input/devices and is not working in
XFree86.
    Milan Roubal

> On Fri, Aug 15, 2003 at 11:25:47AM +0200, Milan Roubal wrote:
> > Hi,
> > I have got problem runing Synaptics touchpad on kernel 2.6.0test3mm2.
> > When previously booted system was windows XP, than the touchpad is
working:
> > here is part of working dmesg:
>
> The touchpad driver uses the new event layer.  You either need
> userspace which understands it.
>
> http://w1.894.telia.com/~u89404340/touchpad/ for XFree86 driver
>
> The other option is to append, is to disable the extensions from
> psmouse by appending
>
> psmouse_noext=1 to your kernel arguments
>
>
> Paul

