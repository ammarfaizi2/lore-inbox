Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSKAP5Q>; Fri, 1 Nov 2002 10:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265067AbSKAP5P>; Fri, 1 Nov 2002 10:57:15 -0500
Received: from host194.steeleye.com ([66.206.164.34]:39186 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265065AbSKAP5O>; Fri, 1 Nov 2002 10:57:14 -0500
Message-Id: <200211011603.gA1G3Z503174@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dominik Brodowski <linux@brodo.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [2.5. PATCH] cpufreq: update HyperThreading support in 
 p4-clockmod.c driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Nov 2002 11:03:35 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the #define for hyperthreading should be #ifdef CONFIG_X86_HT.

Could you also make the symbol export conditional on this so that subarch's 
which don't have hyperthreading will still compile?

Thanks,

James Bottomley




