Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTKONLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKONLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:11:41 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:24276 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261509AbTKONLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:11:41 -0500
Message-ID: <3FB62608.4010708@cyberone.com.au>
Date: Sun, 16 Nov 2003 00:11:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v19a
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/v19a/

So the previous didn't exactly improve interactivity.

This one seems to be better. Major thing is microsecond timeslice
accounting. Other small fixes related to the microsecond stuff.
No idea what this has done to context switch and wake up performance,
but it should be able to be improved a bit.

I've made patches for Linus and Andrew's trees.

