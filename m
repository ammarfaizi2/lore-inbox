Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUJNUCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUJNUCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUJNUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:01:44 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:16143 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S267416AbUJNTyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:54:18 -0400
Message-ID: <416EE7EB.4070209@vt.edu>
Date: Thu, 14 Oct 2004 15:56:11 -0500
From: William Wolf <wwolf@vt.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@zip.com.au
Subject: Re: 2.6.9-rc4-mm1
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I just tried -rc4-mm1 on my amd64 laptop, and my keyboard fails to
work, I don't even think it is being recognized.  I compared the kernel
output from my plain -rc4 boot and my -rc4-mm1 boot.  I'm using the same
.config for each kernel. This is what it shows:

 From -rc4:

Nov 13 19:44:53 Xnix mice: PS/2 mouse device common for all mice
Nov 13 19:44:53 Xnix input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 13 19:44:53 Xnix Synaptics Touchpad, model: 1
Nov 13 19:44:53 Xnix Firmware: 5.9
Nov 13 19:44:53 Xnix 180 degree mounted touchpad
Nov 13 19:44:53 Xnix Sensor: 35
Nov 13 19:44:53 Xnix new absolute packet format
Nov 13 19:44:53 Xnix Touchpad has extended capability bits
Nov 13 19:44:53 Xnix -> multifinger detection
Nov 13 19:44:53 Xnix -> palm detection
Nov 13 19:44:53 Xnix input: SynPS/2 Synaptics TouchPad on isa0060/serio2
Nov 13 19:44:53 Xnix NET: Registered protocol family 2
Nov 13 19:44:53 Xnix IP: routing cache hash table of 8192 buckets, 64Kbytes



 From -rc4-mm1:

Nov 13 20:19:18 Xnix mice: PS/2 mouse device common for all mice
Nov 13 20:19:18 Xnix NET: Registered protocol family 2
Nov 13 20:19:18 Xnix Losing some ticks... checking if CPU frequency changed.
Nov 13 20:19:18 Xnix IP: routing cache hash table of 8192 buckets, 64Kbytes


Any ideas?



