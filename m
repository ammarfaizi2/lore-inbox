Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTJ0BtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 20:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbTJ0BtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 20:49:15 -0500
Received: from hera.cwi.nl ([192.16.191.8]:36064 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263732AbTJ0BtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 20:49:14 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 27 Oct 2003 02:48:52 +0100 (MET)
Message-Id: <UTC200310270148.h9R1mqO06057.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: Andries.Brouwer@cwi.nl, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andries, what was the situation that led to a TCP lockup?

rlogin followed by "emacs -nw".

rlogin uses SIGURG for communication.

It is not the TCP protocol that is locked up.
Keystrokes are transmitted and the results are sent back.
But the reader half of rlogin hangs.

Andries
