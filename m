Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290671AbSARKUR>; Fri, 18 Jan 2002 05:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSARKUI>; Fri, 18 Jan 2002 05:20:08 -0500
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:51161 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S290667AbSARKTw>; Fri, 18 Jan 2002 05:19:52 -0500
From: serizawa@sdl.hitachi.co.jp
To: linux-kernel@vger.kernel.org
cc: lkst-develop@lists.sourceforge.net
Subject: Announcement of Linux Kernel State Tracer (LKST)
X-Mailer: Mew version 1.94b37 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020118192318Q.serizawa@sdl.hitachi.co.jp>
Date: Fri, 18 Jan 2002 19:23:18 +0900 (JST)
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Dear all,

  I'd like to announce publication of Linux Kernel State Tracer (LKST), 
which is a tracer for Linux kernel.
  LKST's main purpose is debugging, fault analysis and performance
analysis of enterprise systems. 
  For the purpose, LKST has these features,
      - It is possible to change dynamically which events are recorded.
        Developers can obtain information about the events which they 
	concern only interesting events.
        And, It reduces the overhead of components which is not related
	with trouble.
      - It is possible to change each handlers related each events.
        A default handler of all events is just recording the events.
        But, if it is necessary, default handler can be changed.
        This function can be used as following,
          +Notify user processes when the handler detects abnormal status.
          +Change a maskset,which controls what type of events should be
           recorded, dynamically by the handler.
           ->  The system can usually run with a few events trace for the
               cause of good performance. And, when the handler detects 
	       abnormal status, it can change a maskset to get more 
	       detail information.

  LKST binaries, source code and documents are available in the following site,
       https://sourceforge.net/projects/lkst/
               or 
       http://oss.hitachi.co.jp/sdl/english/lkst.html (now updating)

  I'm afraid misunderstanding so I add attention.

  - This release is still BETA because some of features 
    are not implemented.
  - Implementation of each trace points is not final but
    tentative. We started to improve this interface, and it will 
    be included this feature in the next release (which will be 
    by end of March in the next year).

  We prepared a mailing list written below in order to let users 
know updates of LKST.

lkst-users@lists.sourceforge.net

To subscribe, please refer following URL,

http://lists.sourceforge.net/lists/listinfo/lkst-users

And if you have any comments, please send to the above list,
or to another mailing list written below.

lkst-develop@lists.sourceforge.net

Kindest regards,
Kazuyoshi Serizawa
Systems Development Laboratory, Hitachi,Ltd.
