Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWCDOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWCDOoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWCDOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:44:14 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:47792 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1751554AbWCDOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:44:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.42927.851653.114068@lemming.engeast.baynetworks.com>
Date: Sat, 4 Mar 2006 09:43:59 -0500
To: linux-kernel@vger.kernel.org
From: psmith@gnu.org
Reply-To: psmith@gnu.org
Subject: kbuild: Problem with latest GNU make rc
X-Mailer: VM 7.19 under Emacs 21.4.1
X-OriginalArrivalTime: 04 Mar 2006 14:44:01.0887 (UTC) FILETIME=[13F366F0:01C63F9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all;

An incompatibility between kbuild and the latest GNU make 3.81 release
candidate has been uncovered by Art Haas.  He reports that when building
current kernels with the latest GNU make rc, everything will always be
rebuilt every time.


I've done an analysis of the issue and reported my findings on
Wednesday, 1 March to the kbuild-devel mailing list (which, according to
its archives, hasn't had any messages go through since 31 Jan--is anyone
approving them anymore?) and to the bug-make mailing list (but a
corruption in lists.gnu.org's TMDA database last week has caused a huge
backlog which is only now being cleared).

For full details you can find an archived copy of my message here:

  http://lists.gnu.org/archive/html/bug-make/2006-03/msg00003.html


The problem is that the new behavior is (I believe) correct.  If I'm
right then this leaves us with a bit of a tricky situation to manage.

If anyone has an opinion or would like to discuss the situation, please
follow up to my email on bug-make@gnu.org (I would prefer to hold the
discussion there since I don't subscribe to linux-kernel).

I would like to come to some kind of decision on this quickly so I can
make an official 3.81 release soon.


Cheers!

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
