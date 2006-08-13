Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWHMQum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWHMQum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHMQum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:50:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38051 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751314AbWHMQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:50:41 -0400
Subject: Re: IRQ Issues with 2.6.17.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Manley <darkhack@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6b4360c80608130836t1169daf2vd5bc6a0a373989e8@mail.gmail.com>
References: <6b4360c80608130836t1169daf2vd5bc6a0a373989e8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Aug 2006 18:10:57 +0100
Message-Id: <1155489057.24077.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at the trace I see only a couple of things and neither look like
problems with the kernel

- your distribution seems to be loading the wrong driver for the network
card (8139cp not 8139too). Take that up with the distro provider I
suspect or check your config has the right drivers included

- The BIOS timer setup is a bit odd in the BIOS. From dmesg we select
the timer via virtual wire mode and sort that out

and the "Cannot allocate resource" one looks harmless too.



So what actual problems are you really seeing (other than the expected
'NDISwrapper doesn't work')

