Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVIQVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVIQVFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVIQVFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 17:05:08 -0400
Received: from daimi.au.dk ([130.225.16.1]:23973 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id S1751198AbVIQVFG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 17:05:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Announce:  Sysprof 1.0 -- a sampling, systemwide Linux profiler
From: Soeren Sandmann <sandmann@daimi.au.dk>
Date: 17 Sep 2005 23:05:04 +0200
Message-ID: <ye8br2r9zi7.fsf@horse06.daimi.au.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* What is it?
--------------------------

Sysprof is a sampling system-wide CPU profiler for Linux.

Sysprof uses a Linux kernel module to profile the entire system, not
just an individual application. 

Of course, sysprof handles threads and shared libraries, and
applications do not have to be recompiled or instrumented. In fact
they don't even have to be restarted. 

Just insert the kernel module and start sysprof.


* Features:
----------------------

    - Profiles all running processes, not just a single application

    - Call graph support showing time spent in each branch of the call tree

    - Has a simple graphical interface

    - Profiles can be loaded and saved

    - Easy to use: Just insert the kernel module and start sysprof

    - Supports Fedora debuginfo packages


* Sysprof 1.0
--------------------------

This is the first release of sysprof with a 1.x version number. I am
very excited about that.

New features since Sysprof 0.91:

- support for x86-64, thanks to Mike Frysinger
- better reporting of time spent in the kernel

Please report bugs as well as success or failure stories to 

    sandmann@daimi au dk


* Where can I get it?
--------------------------------------------

Home page:

       http://www.daimi.au.dk/~sandmann/sysprof/

Source code:

       http://www.daimi.au.dk/~sandmann/sysprof/sysprof-1.0.tar.gz

Sysprof requires

        - Linux 2.6.11 or later, compiled with profiling support
        - GTK+ 2.6
	- libglade 2.5

It is known to work out the box on Fedora Core 4.


Søren
