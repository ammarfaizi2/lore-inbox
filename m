Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266382AbSIRMP5>; Wed, 18 Sep 2002 08:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266418AbSIRMP5>; Wed, 18 Sep 2002 08:15:57 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:31439 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S266382AbSIRMPy>; Wed, 18 Sep 2002 08:15:54 -0400
Message-Id: <5.0.2.6.2.20020918210036.05287a40@sdl99c>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2-Jr1
Date: Wed, 18 Sep 2002 21:20:55 +0900
To: linux-kernel@vger.kernel.org
From: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
Subject: Release of LKST 1.3
Cc: lkst-develop@lists.sourceforge.jp
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

    I'd like to announce publication of Linux Kernel State Tracer (LKST) 1.3,
  which is a tracer for Linux kernel.

    LKST's main purpose is debugging, fault analysis and performance analysis
of enterprise systems.
    For the purpose, LKST has these features,

    (1)It is possible to change dynamically which events are recorded.
        Users can obtain information about the events which they concern
       only interesting events.
        And it reduces the overhead of components which is not related
       with a fault.

    (2)It is possible to change each function invoked by each events.
        A default function invoked by events is just recording occuring of the events.
       But, if it is necessary, this function can be changed to another
       function.
        And LKST supports installing the function by using a kernel module
        LKST also supports a maskset, which controls what kind of events should be
       recorded, can be changed dynamically. For example, LKST usually traces
       a few events for good performance, and when the kernel be in a particular
       status, LKST can change a maskset to get more detail information.

    (3)It is possible to create new buffers and change to one of them.
         By changing to other buffer, Users can leave the information
       which they want.


    LKST binaries, source code and documents are available in the following site,
         https://sourceforge.net/projects/lkst/
         http://sourceforge.jp/projects/lkst/
         http://oss.hitachi.co.jp/sdl/english/lkst.html (now updating)

    We prepared a mailing list written below in order to let users know 
update of LKST.

  lkst-users@lists.sourceforge.net
  lkst-users@lists.sourceforge.jp

  To subscribe, please refer following URL,

  http://lists.sourceforge.net/lists/listinfo/lkst-users
  http://lists.sourceforge.jp/mailman/listinfo/lkst-users

    And if you have any comments, please send to the above list, or to 
another mailing
  list written below.

  lkst-develop@lists.sourceforge.net
  lkst-develop@lists.sourceforge.jp


  With kindest regards,
  All of the LKST developers
----------------
  Yumiko Sugita
  Hitachi,Ltd., Systems Development Laboratory
  
