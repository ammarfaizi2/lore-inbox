Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTJQS47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTJQS47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:56:59 -0400
Received: from ariel.xerox.com ([13.13.138.17]:26301 "EHLO
	ariel.useastgw.xerox.com") by vger.kernel.org with ESMTP
	id S263582AbTJQS46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:56:58 -0400
Message-Id: <200310171857.h9HIvUO24583@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
Subject: why is (*receive_room) in my line discipline being polled?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10319.1066417015.1@eng.mc.xerox.com>
Date: Fri, 17 Oct 2003 14:56:55 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a line discipline for my proprietary protocol at work
over serial on 2.4.22.

I have an internal counter for when receive_room is being called.

In a quiescent, my receive_room method is being polled...(about twice/second).
(no I/O but my devices opened).

Currently I'm using a program called nullmodem which uses pty's to emulate
a serial port...

I don't understand the poll...or why it would happen.


marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
