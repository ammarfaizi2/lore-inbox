Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVCWOGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVCWOGC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCWOGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:06:02 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:33686 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261597AbVCWOF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:05:56 -0500
Subject: Re: memory leak in net/sched/ipt.c?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0503231438290.10048@yvahk01.tjqt.qr>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
	 <1111581618.1088.72.camel@jzny.localdomain>
	 <20050323125516.GP3086@postel.suug.ch>
	 <1111583497.1089.92.camel@jzny.localdomain>
	 <Pine.LNX.4.61.0503231438290.10048@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1111586750.1075.0.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2005 09:05:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 08:40, Jan Engelhardt wrote:
> >I have seen people put little comments of "kfree will work if you
> >pass it NULL" - are you saying such assumptions exist all over
> >net/sched?
> 
> Not only net/sched. The C standard requires that free(NULL) works.

Thanks for clarifying this.

cheers,
jamal

