Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSKXCQy>; Sat, 23 Nov 2002 21:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSKXCQy>; Sat, 23 Nov 2002 21:16:54 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:53501 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267132AbSKXCQx>;
	Sat, 23 Nov 2002 21:16:53 -0500
Message-ID: <3DE03845.4030406@wmich.edu>
Date: Sat, 23 Nov 2002 21:24:05 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpufreq divide error in 2.5.49 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.49 on an intel D850GB motherboard with acpi's on demand clock 
modulation for the P4 has a divide error: 0000 causing a kernel panic 
from attempting to kill init.

It's completely repeatable and just finishes the PCI acpi irq routing 
when it happens on boot.  The cpu i'm using is a 1st gen P4 1.7Ghz, 
non-xeon.

