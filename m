Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTDXRJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTDXRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:09:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263416AbTDXRJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:09:55 -0400
Date: Thu, 24 Apr 2003 10:20:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "ramands" <ramands@indiatimes.com>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: OOPS in Kmalloc
Message-Id: <20030424102036.284ea84e.rddunlap@osdl.org>
In-Reply-To: <200304240813.NAA23499@WS0005.indiatimes.com>
References: <200304240813.NAA23499@WS0005.indiatimes.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| ; Hello,
| ; i am getting OOPS in Kmalloc .
| ;
| ; void **data;
| ; qset = 1000;
| ;
| ; dptr->data = kmalloc(qset * sizeof(char *), GFP_KERNEL);
| ;
| ; what could the possible the cause of the error
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| As I am so fond of saying, it's almost always correct to indicate what
| kernel version one if referring to in a problem report.
| 
| Please decode the oops output and post it here.


I can't reproduce this problem on Linux 2.5.68.
However, I did initialize dptr before using it.  Did you?

You see, I can't tell if you did or not because you didn't post
a complete sample to reproduce the problem.

--
~Randy
