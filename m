Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHZDez>; Sun, 25 Aug 2002 23:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHZDez>; Sun, 25 Aug 2002 23:34:55 -0400
Received: from c-24-126-73-164.we.client2.attbi.com ([24.126.73.164]:40691
	"EHLO kegel.com") by vger.kernel.org with ESMTP id <S317861AbSHZDez>;
	Sun, 25 Aug 2002 23:34:55 -0400
Date: Sun, 25 Aug 2002 20:44:34 -0700
From: dank@kegel.com
Message-Id: <200208260344.g7Q3iY616251@kegel.com>
To: linux-kernel@vger.kernel.org
Subject: re: [PATCH] khttpd crash fix, take 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damn.  Just figured out when khttpd would have to restart
a thread: if the user sends a SIGHUP to the worker daemons.

Guess I have to put the thread restart code back in...
- Dan
