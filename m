Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUKWU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUKWU4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUKWUxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:53:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:37078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261544AbUKWUwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:52:13 -0500
Date: Tue, 23 Nov 2004 12:52:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: keith <kmannth@us.ibm.com>
Cc: devnull@us.ibm.com, djwong <djwong@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SELinux performance issue with large systems (32 cpus)
Message-ID: <20041123125212.E14339@build.pdx.osdl.net>
References: <1101237725.27848.301.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101237725.27848.301.camel@knk>; from kmannth@us.ibm.com on Tue, Nov 23, 2004 at 11:22:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* keith (kmannth@us.ibm.com) wrote:
> I work with i386 16-way systems.  When hyperthreading is enabled they
> have 32 "cpus".  I recently did a quick performance check on with 2.6
> (as it turn out with a SElinux enabled) doing kernel builds.  

Have you tried any recent -mm kernel?  avc_lock was refactored to RCU
locking, and benchmarks shows it scales quite nicely now.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
