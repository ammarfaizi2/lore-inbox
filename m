Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUDKXGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUDKXGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 19:06:37 -0400
Received: from tungsten.bulletproof.net.au ([203.222.130.34]:3508 "EHLO
	tungsten.bulletproof.net.au") by vger.kernel.org with ESMTP
	id S262542AbUDKXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 19:06:36 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.5 sound arch dependency problem
Message-ID: <1081724791.4079cf776e5b0@webmail.bulletproof.it>
Date: Mon, 12 Apr 2004 09:06:31 +1000 (EST)
From: Jon Tidswell <firstname@lastname.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 202.172.121.111
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel 2.6.5

Unlike the arch/* directory the makefile for the sound subsystem is not
robust about missing architecture subdirectories.

delete arch/{arm,sparc,...} and make mrproper succeeds

delete sound/{arm,sparc,...} and make mrproper fails


Jon Tidswell                                          <firstname@lastname.org>
Disclaimer: I think my thoughts are my own, and I believe my writings are too.
