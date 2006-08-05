Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWHESsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWHESsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 14:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWHESsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 14:48:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30692 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751467AbWHESsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 14:48:01 -0400
Date: Sat, 5 Aug 2006 14:47:55 -0400
From: Dave Jones <davej@redhat.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805184755.GA25644@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com> <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com> <6bffcb0e0608050354k4dd0bb0ep337216e984ce41d7@mail.gmail.com> <6bffcb0e0608050411q22112b71wced519a6491c6abe@mail.gmail.com> <6bffcb0e0608050426s6c39e4f0o57f9093b03c3b27b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608050426s6c39e4f0o57f9093b03c3b27b@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 01:26:49PM +0200, Michal Piotrowski wrote:

 > Aug  5 13:18:00 ltg01-fedora kernel: CPU0 called lock_cpu_hotplug()
 > for app kded. recursive_depth=0
 > *more snipped traces*

The interesting ones will be the ones before & after you hit that
BUG: warning at /usr/src/linux-work1/kernel/cpu.c:51/unlock_cpu_hotplug()
if you can make that happen again.

		Dave

-- 
http://www.codemonkey.org.uk
