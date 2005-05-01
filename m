Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVEAOOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVEAOOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 10:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEAOOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 10:14:39 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:34788 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261630AbVEAOOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 10:14:38 -0400
Subject: Re: Compaq Armada E500 notebook and 2.6.x kernels
From: =?ISO-8859-1?Q?Beno=EEt?= Rouits <brouits@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 01 May 2005 16:15:04 +0200
Message-Id: <1114956905.12478.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Gábor,
I recently installed a 2.6.10 and 2.6.11 kernel on my laptop and they
froze about 5 minutes after booting. My solution was to give those 2
options to the kernels:
lilo boot: mykernel noapic nolapic
apic and Local apic are Advanced Programmable Interrupt Controller
I don't know why the local aic doesn't works in Sempron..

My laptop is an HP/Compaq with an AMD Sempron inside and a phoenix bios
HTH,
--
ben

