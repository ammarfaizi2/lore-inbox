Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVAUUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVAUUjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVAUUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:37:56 -0500
Received: from anubis.aker.com.br ([200.101.19.4]:28101 "EHLO
	firewall.aker.com.br") by vger.kernel.org with ESMTP
	id S262498AbVAUUbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:31:31 -0500
Message-ID: <41F166A1.4030000@aker.com.br>
Date: Fri, 21 Jan 2005 18:31:29 -0200
From: Jorge Peixoto Vasquez <jorge@aker.com.br>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via-rhine tx timeouts (AGAIN)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

This error seems to appear and re-appear periodically in this list.

This time's encarnation is triggered by a sequence of changing the board 
state to up and down.

When this happens, the system can no longer send data through the board 
and keeps periodically printing (each other second or so):

NETDEV WATCHDOG: eth0 trasmit timed out
eth0: Trasmit timed out, status 0000, PHY status 786d, reseting ...
eth0: Reset not complete yet. Trying harder.
eth0:  Setting full duplex based on MII .... capability of  45e1.

ifconfig up / down again won't recover from the problem.
This box serves as a firewall, so there is traffic all the time during 
the sequence described above comming from other interfaces.

This behaviours first showed up when loading the slhc.o PPP driver, 
which wasn't used before.

And this machine has neither APIC or ACPI enabled and runs kernel 
2.4.26. Switching to kernel 2.4.29 didn't help at all.

Any ideas?

jOrge

-- 
Jorge Peixoto Vasquez, Elect. Eng.
Aker Security Solutions - www.aker.com.br

