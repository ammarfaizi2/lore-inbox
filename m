Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSDOKVY>; Mon, 15 Apr 2002 06:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSDOKVX>; Mon, 15 Apr 2002 06:21:23 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:32742 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S293035AbSDOKVW>; Mon, 15 Apr 2002 06:21:22 -0400
Message-Id: <5.0.2.6.2.20020415191635.00c5aeb0@sdl99c>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2-Jr1
Date: Mon, 15 Apr 2002 19:21:51 +0900
To: linux-kernel@vger.kernel.org
From: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
Subject: Release of LKST 1.0
Cc: lkst-develop@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

    I'd like to announce publication of Linux Kernel State Tracer (LKST) 1.0,
  which is a tracer for Linux kernel.

    LKST's main purpose is debugging, fault analysis and performance analysis of
  enterprise systems.
    For the purpose, LKST has these features,

        - It is possible to change dynamically which events are recorded.
          Developers can obtain information about the events which they
         concern only interesting events.
          And, It reduces the overhead of components which is not related
         with trouble.

        - It is possible to change each function invoked each events.
          A default function of all events is just recording the events.
          But, if it is necessary, default function can be changed to
         another function.
          For example, this feature can be used as following:
            + Notify user processes when the function detects abnormal status.
            + Change a maskset,which controls what type of events should be
             recorded, dynamically by the function.
             ->  The system can usually run with a few events trace for the
                 cause of good performance. And, when the function detects
                abnormal status, it can change a maskset to get more
                detail information.
          Users can create and install any function as kernel module.


     We released the beta version of LKST in January, 2002. And the followings are
   added with the LKST 1.0.

      - Replace the current trace hooks with Kernel Hooks (formerly known as GKHI)
        by IBM.
      - Integrate with Linux Kernel Crash Dump (LKCD) to analyze the trace data
        in a crash dump.
      - Making of daemon that saves trace data into log files.

    Note: The LKCD patch is not a official patch. If the official patch is released,
       we will replace it with the official patch and release the LKST again.


    LKST binaries, source code and documents are available in the following site,
         https://sourceforge.net/projects/lkst/
                 or
         http://oss.hitachi.co.jp/sdl/english/lkst.html (now updating)

    We prepared a mailing list written below in order to let users know 
update of LKST.

  lkst-users@lists.sourceforge.net

  To subscribe, please refer following URL,

  http://lists.sourceforge.net/lists/listinfo/lkst-users

    And if you have any comments, please send to the above list, or to 
another mailing
  list written below.

  lkst-develop@lists.sourceforge.net

  With kindest regards,

All of the LKST developers

----------------
  Yumiko Sugita
  Hitachi,Ltd., Systems Development Laboratory
   
