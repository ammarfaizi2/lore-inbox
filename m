Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUA3Auk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUA3Auk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:50:40 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:7582 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S266212AbUA3Aui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:50:38 -0500
Message-ID: <4019AA2D.7010609@oracle.com>
Date: Fri, 30 Jan 2004 01:49:49 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Alt-SysRq-B doesn't work in recent 2.6 kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that my oops-on-boot has been fixed thanks to many on lkml
  and a spot-on tip by Len Brown, I'll chase another one of the
  issues I still have :)

The problem in $subject happens reliably at least in 2 cases:

  1. after the ACPI oops-on-boot (-mm tree and 2.6.2-rc2+)
  2. in 2.6.2-rc1+ after the Cisco VPN client daemon (cvpnd,
      v.4.0.3.B) gets stuck in D state [__down] and I try to
      shutdown but obviously that gets stuck in turn

In both cases I can Alt-SysRq-{P,T,S,U,O} [though in case 1
  Off only prints out "Power Off" but doesn't actually do it],
  and when I attempt a Alt-SysRq-B I only get

atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.

  and no effect at all.


Available for testing, as usual :) thanks in advance & ciao,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

