Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265470AbUEZK5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUEZK5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUEZK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:56:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:7809 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265472AbUEZKyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:54:44 -0400
Date: Wed, 26 May 2004 06:54:37 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: ap@solarrain.com
Subject: Dell GX1 500 MHZ locked up with Kernel 2.4.26 due to ACPI -- Also:
 IPTables question.
Message-ID: <Pine.LNX.4.60.0405260653450.1712@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only thing changed was from 2.4.16 build 13 -> build 14 was that I enabled 
ACPI, had APM & ACPI both compiled into the kernel, I just wanted to try 
out ACPI to see if it worked on an older system.

I previously have had a > 190 day uptime (without ACPI in the kernel, an 
older kernel of course, but I believe it is ACPI that caused the problem).

Also, I do have APIC in the kernel and always have it in the kernel; it is 
ACPI that caused the lockup.

HOWEVER:

My monitor was in power save mode (I run X on it), the caps lock & scroll 
lock key were flashing on and off (but not the num lock key) . there was 
nothing in the logs as to why it crashed (paniced), is there some way I 
can see what the panic message is if this ever happens again (even though 
it shouldn.t because I disabled ACPI)?

Perhaps using serial port..? or perhaps one of the network options for 
syslogd/errors/panics, but these are only for 2.6.x?

The reason why I don.t use 2.6.x yet is 2.4.x has patch-o-matic modules 
(h323,realplayer,msmedia conn trackers) that 2.6. does not seem to have.

Further question regarding iptables, will fragmented packets ever be able 
to be blocked/logged with connection trackers? (ie: A machine could 
theoretically be DoS.d and if they are using connection_trackers, they 
would not see it via iptables), only tcpdump/similar.

Thanks.

