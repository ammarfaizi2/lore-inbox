Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTKEUo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 15:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKEUo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 15:44:57 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:14812 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S263181AbTKEUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 15:44:57 -0500
Date: Wed, 5 Nov 2003 21:44:49 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: mii broken for 3c59x ?
Message-ID: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two 3com 3c905C-TX NICs in my linux box.
I remember that mii-tool used to work.

Now, with 2.6.0-test9-bk8 it does not.

dns:~# mii-tool
SIOCGMIIPHY on 'eth0' failed: Operation not supported
SIOCGMIIPHY on 'eth1' failed: Operation not supported
no MII interfaces found

What might be going on here? Did we have any recent changes in this,
or maybe my software's outdated, or NICs broken ?
It's Debian Sarge.

mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)

Regards,
Maciej
