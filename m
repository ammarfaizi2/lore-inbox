Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263236AbSJCLNV>; Thu, 3 Oct 2002 07:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263235AbSJCLNV>; Thu, 3 Oct 2002 07:13:21 -0400
Received: from mail.webmaster.com ([216.152.64.131]:7604 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263234AbSJCLNU> convert rfc822-to-8bit; Thu, 3 Oct 2002 07:13:20 -0400
From: David Schwartz <davids@webmaster.com>
To: <hps@intermeta.de>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Thu, 3 Oct 2002 04:18:36 -0700
In-Reply-To: <anh7es$mpl$1@forge.intermeta.de>
Subject: Re: Sequence of IP fragment packets on the wire
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20021003111847.AAA15244@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002 10:51:08 +0000 (UTC), Henning P. Schmiedehausen wrote:

>as far as I can see, Linux sends out fragmented IP packets
>"butt-first":
>(where the first packet is actually the fragmented 2nd part of the
>second packet).
>
>This confuses at least one firewall appliance.

	I'm afraid that this firewall appliance is fundamentally broken. Nothing you 
can do to Linux can fix this fundamental breakage. I can give further 
examples, analogies, and argumentation, but it really should be obvious that 
IP, fundamentally, does not guarantee any particular reception order and 
anything that assumes it does cannot be fixed except by changing the 
assumption.

	This is as bad as a TCP application that assumes one 'read' call will return 
an entire line or command. You cannot push the problem elsewhere.

	DS


