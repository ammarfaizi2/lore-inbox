Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277659AbRJLM6X>; Fri, 12 Oct 2001 08:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277665AbRJLM6N>; Fri, 12 Oct 2001 08:58:13 -0400
Received: from mail114.mail.bellsouth.net ([205.152.58.54]:32155 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S277659AbRJLM6I>; Fri, 12 Oct 2001 08:58:08 -0400
Message-ID: <3BC6E89A.BA8F98B6@bellsouth.net>
Date: Fri, 12 Oct 2001 08:56:58 -0400
From: Steve Martin <ecprod@bellsouth.net>
Organization: WATE-TV, Knoxville, TN
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: IEEE1284 parport code won't build in 2.4.12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has already been passed on to Tim Waugh, but here's
a heads-up:

drivers/parport/ieee1284_ops.c  -- invokes an undefined
enum entry from parport.h  -- as a result the code
won't build.

