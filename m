Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUFJTGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUFJTGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUFJTGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:06:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:54967 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262434AbUFJTFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:05:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.45292.400650.173398@alkaid.it.uu.se>
Date: Thu, 10 Jun 2004 21:05:16 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Steve Lee" <steve@tuxsoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: APIC error on CPU1: 00(02) && APIC error on CPU0: 00(02)
In-Reply-To: <000401c44f13$da874e90$8119fea9@pluto>
References: <000401c44f13$da874e90$8119fea9@pluto>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lee writes:
 > APIC error on CPU1: 00(02)
 > APIC error on CPU0: 00(02)
 > 
 > I've spent some time trying to research these error messages, but I'm
 > not exactly sure what I'm looking at.  I've read that these may indicate
 > a faulty or soon to go faulty processor.  However, when I do get these
 > errors, it always involves both processors.  What are the odds both
 > would be dying at the same time?

02 == receive checksum error on the local APIC bus.
This tells us that you have an MP board with P6 or AMD
processors, and that the system has hardware problems.
Likely problems: bad board design (BP6 anyone?), inadequate
cooling, inadequate power supply, overclocked processors,
or using processors not validated for MP.
