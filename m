Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTHTRqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTHTRq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:46:29 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:4774 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S262122AbTHTRpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:45:42 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308201745.SAA23241@mauve.demon.co.uk>
Subject: Re: Console on USB
To: tmolina@cablespeed.com (Thomas Molina)
Date: Wed, 20 Aug 2003 18:44:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List), greg@kroah.com,
       zwane@linuxpower.ca (Zwane Mwaikambo)
In-Reply-To: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain> from "Thomas Molina" at Aug 19, 2003 10:20:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have just spent a very frustrating evening trying to get console on USB 
> working.  My laptop does not have regular DB-9 serial connectors, only 
> USB.  So I ordered a USB to serial converter, configured a 2.6.0-test3 
> kernel, added a console=/dev/ttyUSB0 to the kernel command line and 
> connected this to my desktop with a null modem adapter.  However, I am 
> unable to get output from this setup on the desktop.  On another setup I 
> can get a normal serial console output, so I am fairly confident I can set 
> things up correctly.

For laptops, might console=/dev/irda work?

