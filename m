Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTKXVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTKXVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:08:09 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:29887 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261563AbTKXVIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:08:07 -0500
To: henning@meier-geinitz.de, vojtech@suse.cz, rusty@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Reply-to: mmayer@uci.edu
Subject: USB printer and scanner modules don't load automatically in linux-2.6.0-test10
Name: Meinhard E. Mayer, Research Professor 
Organization: Department of Physics, U C. Irvine. Ph. (949) 824-5543
X-Mailer: Gnu/Linux-Fedora-1 kernel 2.6.0; xemacs-21.5.16, nmh-1.0.4
Date: Mon, 24 Nov 2003 13:08:05 -0800
From: "Meinhard E. Mayer" <hardy@bill.ps.uci.edu>
Message-Id: <20031124210755.FNIR9968.fed1mtao05.cox.net@bill.ps.uci.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know whether I am supposed to ssend this to any of you or the
general list.
I have been using -test9 and -test10 for a while and noticed that the
modules for my connected USB printer and scanner did not load
automatically during boot (as they do in kernel-2.4.22-1.2115.nptl
(Fedorea-SC1) or other versions of 2.4.22). 
The alternatives were to enter 
sudo modprobe usbpr
sudo modprobe scanner
or to compile the drivers into the kernel (which I ultimately did). 
I could not figure out the correct format for the new /etc/modprobe.conf
to remedy this; I also compiled the soundcard-driver into the kernel
since the test9 kernel. 
 

--
Hardy
(Meinhard E. Mayer)
Professor Emeritus
U. C. Irvine
