Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUDNQwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUDNQwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:52:49 -0400
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:1479 "EHLO
	av7-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S264291AbUDNQwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:52:23 -0400
Subject: atkbd scroll-wheel and extra buttons
From: =?ISO-8859-1?Q?J=F6rgen?= Lidholm <jlm01001@student.mdh.se>
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1081961633.1434.17.camel@caimeara.home.sen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Apr 2004 18:53:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a "Microsoft Wireless Desktop Elite Keyboard" and I like it a
lot.
When I saw the post about the on-keyboard-wheel support I tried to
get it to work. But sadly I didn't.
When I run xev and spinns the wheel up and down nothing is reported.
Though the evtest program (I think most of you know about it already)
do report stuff about it

My questions are:
The wheel codes are hardcoded into atkbd.c, are these codes reported by
the keyboard?
If not what is reported for the working keyboards?
Where do I start if I would like to add support for my scrollwheel? Is
it the event interface or is it the atkbd driver? Or might it just be a 
configuration issue?

I've added atkbd.scroll=1 boot option.
By the way the evtest report the following for my wheel

Event: time 1081961368.154573, type 2 (Relative), code 9 (?), value 1
Event: time 1081961368.154577, type 0 (Reset), code 0 (Reset), value 0

This is one "scroll-step" the value differs depending on the speed and
direction of the scroll. Negative values for scrolling down.

/Joergen
-- 
Jörgen Lidholm
Student, University of Mälardalen

jlm01001(at)student(dot)mdh(dot)se

