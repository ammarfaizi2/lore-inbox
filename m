Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbSLKL7R>; Wed, 11 Dec 2002 06:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLKL7R>; Wed, 11 Dec 2002 06:59:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59776 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S267119AbSLKL7Q>;
	Wed, 11 Dec 2002 06:59:16 -0500
Date: Wed, 11 Dec 2002 07:07:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench for some recent kernels
Message-ID: <Pine.LNX.4.44.0212110704130.4060-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing the Redhat 7.3 kernel with some recent 2.5 kernels. All on a 
dual Celeron 500 with an SMP kernel run with the "nosmp" option.


================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average
  2.4.18-10nosmp-bl       62700      63254      63049
  2.5.41nosmp-bl          55048      55660      55418
  2.5.43nosmp-bl          50093      50250      50176
  2.5.47-ac6nosmp-bl      54200      54236      54215
  2.5.50nosmp-bl          51675      56403      54818

                                   loops/sec
message queue               low       high    average
  2.4.18-10nosmp-bl      105275     105737     105513
  2.5.41nosmp-bl         108057     108413     108232
  2.5.43nosmp-bl         100698     101835     101325
  2.5.47-ac6nosmp-bl      98086      98223      98157
  2.5.50nosmp-bl         104965     105261     105105

                                   loops/sec
pipes                       low       high    average
  2.4.18-10nosmp-bl       86794      88484      87637
  2.5.41nosmp-bl          74026      78242      76734
  2.5.43nosmp-bl          80559      81233      80953
  2.5.47-ac6nosmp-bl      71277      78883      75415
  2.5.50nosmp-bl          81211      81529      81411

                                   loops/sec
semiphore                   low       high    average
  2.4.18-10nosmp-bl      114407     114644     114537
  2.5.41nosmp-bl         114459     114658     114535
  2.5.43nosmp-bl         113222     113423     113322
  2.5.47-ac6nosmp-bl      95986      96347      96179
  2.5.50nosmp-bl         110582     112044     111450

                                   loops/sec
spin+yield                  low       high    average
  2.4.18-10nosmp-bl      189489     190677     190102
  2.5.41nosmp-bl         250737     251116     250867
  2.5.43nosmp-bl         249474     249836     249607
  2.5.47-ac6nosmp-bl     245594     245905     245740
  2.5.50nosmp-bl         252055     252529     252361

                                   loops/sec
spinlock                    low       high    average
  2.4.18-10nosmp-bl           3          3          3
  2.5.41nosmp-bl              3          3          3
  2.5.43nosmp-bl              3          3          3
  2.5.47-ac6nosmp-bl          3          3          3
  2.5.50nosmp-bl              3          3          3

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


