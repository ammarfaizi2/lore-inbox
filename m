Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTDZDhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 23:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTDZDhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 23:37:54 -0400
Received: from polaris.galacticasoftware.com ([206.45.95.222]:10368 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S263038AbTDZDhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 23:37:53 -0400
From: Adam Majer <adamm@galacticasoftware.com>
Date: Fri, 25 Apr 2003 22:49:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Is serial driver in 2.4.20 not SMP clean?
Message-ID: <20030426034923.GA1450@galacticasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having some serious problems with the serial driver in 2.4.20 kenrnel
(from Debian) compiled with GCC 2.95.4

My server is a dual PPro with ECC memory. It has never crashed until
I started using the serial port for the modem. During a connection,
it suddenly froze with no keyboard response at all and _nothing_
on the screen. I thought maybe something overheated or what not.

Two days later, I tried using the modem once more. After about
30 minutes and 1.5M later, there was a hard crash once more.

I never experienced that with a non-SMP machine. And I never
used SMP with serial driver...


serial is compiled as module.


Any ideas?


- Adam
