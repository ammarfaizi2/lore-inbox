Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVCFSuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVCFSuo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCFSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:50:44 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:1006 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S261465AbVCFSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:50:40 -0500
Subject: Re: NMI watchdog question
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Mar 2005 19:51:40 +0100
Message-Id: <1110135101.8018.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert Hancock wrote:
>> Pallai Roland wrote:
>> [...]
>> I'm playing with the NMI watchdog (nmi_watchdog=1) on a reproductable
>> hard lockup (no keyboard, etc) but seems like it doesn't works and I
>> can't understand why, please explain to me the possible causes.. I
>> belive it should work in this situation..
>
> The NMI watchdog only triggers if something is blocking interrupts from
> getting through - if timer interrupts are still happening it won't
> activate. You can try Alt-Sysrq-T to get a traceback of where the
> current process is stuck..

 the keyboard is dead (no num lock, no sysrq) just like the serial port,
the network, etc..


--
 d

