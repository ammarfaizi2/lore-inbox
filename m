Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTKYRGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKYRGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:06:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33799 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261875AbTKYRGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:06:31 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: USB printer and scanner modules don't load automatically in linux-2.6.0-test10
Date: 25 Nov 2003 16:55:33 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bq01i5$4g0$1@gatekeeper.tmr.com>
References: <20031124210755.FNIR9968.fed1mtao05.cox.net@bill.ps.uci.edu>
X-Trace: gatekeeper.tmr.com 1069779333 4608 192.168.12.62 (25 Nov 2003 16:55:33 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031124210755.FNIR9968.fed1mtao05.cox.net@bill.ps.uci.edu>,
Meinhard E. Mayer <mmayer@uci.edu> wrote:
| I don't know whether I am supposed to ssend this to any of you or the
| general list.
| I have been using -test9 and -test10 for a while and noticed that the
| modules for my connected USB printer and scanner did not load
| automatically during boot (as they do in kernel-2.4.22-1.2115.nptl
| (Fedorea-SC1) or other versions of 2.4.22). 
| The alternatives were to enter 
| sudo modprobe usbpr
| sudo modprobe scanner
| or to compile the drivers into the kernel (which I ultimately did). 
| I could not figure out the correct format for the new /etc/modprobe.conf
| to remedy this; I also compiled the soundcard-driver into the kernel
| since the test9 kernel. 

Before demand loading can work you need to put the path to the module
loader program in /proc/sys/kernel/modprobe (from memory). Yes, that
makes booting a portable kernel using initrd more complex...
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
