Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVFRMc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVFRMc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 08:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVFRMc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 08:32:28 -0400
Received: from mail.linicks.net ([217.204.244.146]:54801 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262103AbVFRMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 08:32:27 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 13:32:25 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181332.25287.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

2.6.12, GCC 3.4.4 on Slackware 10 base

New 2.6.12 build hangs at initialising udev dynamic device directory on boot.  
I used make oldconfig from 2.6.11.12, and all the new changes I selected N, 
all bar nvidia FB support (I built several times, as I have a GeForce4 card, 
so suspected the nvidia FB support at first and turned off).

2.6.11.12 works perfect.

I have just spent an hour or so investigating, but I am none the wiser.

Ideas what could be causing this?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
