Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUDVI6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUDVI6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDVI6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:58:44 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:44681 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263893AbUDVI5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:57:08 -0400
Message-ID: <408788A1.8060702@bull.net>
Date: Thu, 22 Apr 2004 10:56:01 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Announce] Enhanced Linux System Accounting - ELSA project
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

     We are pleased to announce a new project about accounting on Linux. 
  This project is called ELSA (Enhanced Linux System Accounting) and a 
description follows. Any comments, ideas or participation are welcome.

              --------------------------------------------------
               ELSA (Enhanced Linux System Accounting) announce
                          http://elsa.sourceforge.net
              --------------------------------------------------


      The goal of accounting is to collect and report the use of various 
system resources by applications. Informations, like process time, CPU 
usage, connect time or disk space usage, provides data that helps the 
system to adjust the use of resources between processes.

      The current BSD-like process accounting that already exists in 
Linux collects informations on individual users or groups of users. The 
ELSA project aims to improve and extend the monitoring of resources with 
different criteria like groups of processes. Another target for this 
project is to give Linux an homogeneous set of commands for all kinds of 
accounting (memory, CPU and I/O).

      Here is the state of the art about ELSA (Enhanced Linux System 
Accounting).

Concerning the documentation:
=============================

        o  All drafts can be access at
           http://sourceforge.net/docman/?group_id=105806

Concerning the code:
====================

        o  The structure "bank" allowing to manage groups of process is
           based on Linux kernel 2.6.5
        o  A test program is provided making it possible to validate our
           implementation.
        o  Currently, these structures can be handled by a user via the
           system call elsa(). A functional patch is provided on the web
           site
           http://sourceforge.net/project/showfiles.php?group_id=105806

Concerning the CVS:
===================

        o  The module structure is a little tricky because we have
           created some useless repositories. Anyway, there are 4 modules
           which are:
               - modifs_kernel: contains modified files for a Linux
                 kernel 2.6.5. We don't support versions 2.4.x for the
                 moment but if it's needed, it's easy to port.
               - tests: a program that allows to test the "bank" and a
                 basic Makefile to build the test.
               - drafts: contains the documents relating to ELSA.
               - scripts: Scripts can manage an environment of work. It
                 just copies files between environments. It's more for a
                 personal use.

          There are also two unused modules which are:
              - elsa
              - Documentation

Here is the state of the art.
Feel free to give your opinion. Any comments, ideas or participation
are welcome.

Regards,
The ELSA team




