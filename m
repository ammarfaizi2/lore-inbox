Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTKZK6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTKZK6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:58:46 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:10122 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264142AbTKZK6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:58:43 -0500
Message-ID: <001c01c3b40c$3e7666a0$0e25fe0a@pysiak>
From: =?iso-8859-2?Q?Maciej_So=B3tysiak?= <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Subject: Networking gets extremely laggy after a random amount of time.
Date: Wed, 26 Nov 2003 11:58:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been writing about this problem several times, always without
receiving any pointers on how to approach this.

Networking gets extremely laggy after a random amount of time.
Sometimes it is 5 minutes, sometimes 30hours, sometimes 5 days.

By laggy, I mean that each connection that is established from or to
the linux box (even on the same LAN) is very slow and jitters.
SSH and telnet sessions jitter. When I press a key for a few seconds
it writes in batches, like:
eeee e ee ee eeeeeee e ee

Other streams like http, smtp are very slow.

The only thing that fixes this is to do a /etc/init.d/networking restart

It has been happening on Debian woody and sarge with kernels
from 2.4.16 (the earliest tested) to 2.4.23-rc4 and even on each
2.6 kernel I tried on that box.

The machine is not loaded, and connections I make that are
on localhost device are ok, when these conditions are on.

It propably is NIC related, but I do not know how to investigate
this. I have two 3com 3c905c-tx NICs. One of them is connected
to the LAN, and the other is connected to a hub and is sometimes
used to listen in promiscous mode to investigate traffic.

I would appreciate any pointers on where to look for problems.

Best regards,
Maciej

