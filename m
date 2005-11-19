Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVKSBBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVKSBBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKSBBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:01:33 -0500
Received: from fox.web.itd.umich.edu ([141.211.144.141]:45547 "EHLO
	fox.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S1751184AbVKSBBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:01:32 -0500
Message-ID: <20051118200132.jiwizt3ho0ook00w@web.mail.umich.edu>
Date: Fri, 18 Nov 2005 20:01:32 -0500
From: jstipins@umich.edu
To: linux-kernel@vger.kernel.org
Subject: AMD 64 system clock speed
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Remote-Browser: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
	rv:1.7.12) Gecko/20050915 Firefox/1.0.7
X-IMP-Server: 141.211.144.110
X-Originating-IP: 71.82.73.173
X-Originating-User: jstipins
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

My earlier question regarding the glibc "make check" nptl/tst-clock2.c
failure turns out to be due to my system clock running 3x normal speed.

Evidently, this is a known issue with 2.6.x kernels running on AMD 64
processors.  The "noapic" boot option fixes the clock problem, but disrupts
other things... ethernet does work, etc.  The solution seems to be using
"apci=noirq noapic" as boot options.

I am using the 2.6.14.2 kernel, and still need to use those boot parameters.
What is the current state of this bug?

-Janis
