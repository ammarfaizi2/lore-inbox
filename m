Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVLPLgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVLPLgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLPLgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:36:14 -0500
Received: from main.gmane.org ([80.91.229.2]:18067 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751256AbVLPLgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:36:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: 2.6.15-rc5-rt2 slowness
Date: Fri, 16 Dec 2005 12:30:30 +0100
Message-ID: <dnu8ku$ie4$1@sea.gmane.org>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 134.130.238.18
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks to Steven's Kconfig fixes I was able to compile 2.6.15-rc5 with
Ingo's rt2-patch just fine.

I have two small problem with it, however. One is the Oops just posted, the
other is a high system load and bad responsiveness of the system as a
whole. I didn't even bother to measure timer/sleep jitters as the system
was dog slow and the fans started to run a full speed nearly immediately.

We observed this on two different systems, one with the config attached to
my mail with the Oops/backtrace.

I'll try to recompile the kernel with some debug options, if anyone knows if
there's something I should specifically look for this may be helpful.

Greetings,

  Gunter

