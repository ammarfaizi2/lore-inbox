Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423061AbWJZKAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWJZKAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWJZKAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:00:35 -0400
Received: from science.horizon.com ([192.35.100.1]:45384 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1423061AbWJZKAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:00:34 -0400
Date: 26 Oct 2006 06:00:27 -0400
Message-ID: <20061026100027.32164.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, zippel@linux-m68k.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610261144230.6761@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please specify "+ linuxpps".

http://gitweb.enneenne.com/?p=linuxpps;a=summary
http://wiki.enneenne.com/index.php/LinuxPPS_support

It's a PPS-input timestamping driver, touching drivers/serial/8250.c
and the like.  No contact with kernel timekeeping code, other than
calling it to obtain the timestamps.

I can send you NTP logs if you like; I just thought they were a bit
bulky for linux-kernel.

I don't think its use of netlink is entirely appropriate, but it works
well enough.
