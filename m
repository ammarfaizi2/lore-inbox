Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUIOO17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUIOO17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIOO1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:27:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266467AbUIOOYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:24:37 -0400
Date: Wed, 15 Sep 2004 07:24:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: thockin@hockin.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-Id: <20040915072400.185e8ce9.pj@sgi.com>
In-Reply-To: <4147FE3A.1020504@ppp0.net>
References: <20040915011146.GA27782@hockin.org>
	<1095214229.20763.6.camel@localhost>
	<20040915031706.GA909@hockin.org>
	<20040915034229.GA30747@kroah.com>
	<20040915044830.GA4919@hockin.org>
	<20040915050904.GA682@kroah.com>
	<20040915062129.GA9230@hockin.org>
	<4147E525.4000405@ppp0.net>
	<20040915064735.GA11272@hockin.org>
	<4147E649.1060306@ppp0.net>
	<20040915065515.GA11587@hockin.org>
	<4147F1B4.1060009@ppp0.net>
	<20040915005613.2a64f536.pj@sgi.com>
	<4147FE3A.1020504@ppp0.net>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan wrote:
> And how do you know which memory modules are near cpu0 and 1 ?

So far as the current code is concerned, "memory" and "node" are synonyms.

Notice for example the files such as:

  /sys/devices/system/node/node0/meminfo

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
