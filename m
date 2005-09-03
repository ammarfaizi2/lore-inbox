Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbVICBwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVICBwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICBwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:52:36 -0400
Received: from 59-171-177-165.rev.home.ne.jp ([59.171.177.165]:31880 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1751355AbVICBwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:52:35 -0400
Date: Sat, 03 Sep 2005 10:52:33 +0900 (JST)
Message-Id: <20050903.105233.1300518464.whatisthis@jcom.home.ne.jp>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [x86_64] Exception when using powernowd.
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
In-Reply-To: <20050902172437.7e8ceabd.akpm@osdl.org>
References: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
	<20050902172437.7e8ceabd.akpm@osdl.org>
X-Mailer: Mew version 4.2.52 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx,Andrew,

Written by Andrew Morton <akpm@osdl.org>
   at Fri, 2 Sep 2005 17:24:37 -0700 :
Subject: Re: [x86_64] Exception when using powernowd.

akpm> Kyuma Ohta <whatisthis@jcom.home.ne.jp> wrote:
akpm> >
akpm> > I'm using MSI K8T Neo2 (VIA K8T800 chipset) and Athlon64 3000+
akpm> > with  linux x86_64 2.6.13 kernel and Debian/sid.
akpm> > When enable powernow-k8 (i.e. using powernowd,cpudyn) to
akpm> > saving power, some process is down by null protection and
akpm> > system is unstable.
akpm> > Then disabling powernow-k8,and reboot, system is very stable.
akpm> > 
akpm> > I attach any log,please give me a advice.
akpm> 
akpm> Did earlier kernels work OK?  Can you identify the most recent 2.6 kernel
akpm> which didn't have this bug?

 Without powernow! feature, works fine.(I tested every -rc kernel 
after 2.6.8 for x86_64).
 With powernow! feature,works bad at least after 2.6.11-rc*.

 I'm using xserver-xorg at debian,6.8.2-dfsg.1-5 happend OOPS 
at any process using X any older kernel, but update X to 6.8.2-6,
any processes not/with using  X got  null exception and down
when enable powernow! feature :-(
 What happened? 

Ohta.
