Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVCWNkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVCWNkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVCWNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:40:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36302 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261592AbVCWNkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:40:42 -0500
Date: Wed, 23 Mar 2005 14:40:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: memory leak in net/sched/ipt.c?
In-Reply-To: <1111583497.1089.92.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.61.0503231438290.10048@yvahk01.tjqt.qr>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au> 
 <1111581618.1088.72.camel@jzny.localdomain>  <20050323125516.GP3086@postel.suug.ch>
 <1111583497.1089.92.camel@jzny.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have seen people put little comments of "kfree will work if you
>pass it NULL" - are you saying such assumptions exist all over
>net/sched?

Not only net/sched. The C standard requires that free(NULL) works.


Jan Engelhardt
-- 
