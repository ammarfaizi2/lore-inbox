Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWJTMXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWJTMXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWJTMXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:23:14 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:5332 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964795AbWJTMXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:23:13 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Olof Johansson <olof@lixom.net>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk>
	<20061019180659.200d7763@pb15>
Date: Fri, 20 Oct 2006 14:22:58 +0200
In-Reply-To: <20061019180659.200d7763@pb15> (Olof Johansson's message of "Thu,
	19 Oct 2006 18:06:59 -0500")
Message-ID: <87ac3ryy59.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olof" == Olof Johansson <olof@lixom.net> writes:

 >> +static int __devinit ulite_probe(struct platform_device *pdev)

 Olof> You never fill in the 'line' member here, so probing of a second
 Olof> uartlite port will fail.

Ah yes, sorry about that. I'll send a patch to Andrew.

-- 
Bye, Peter Korsgaard
