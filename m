Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSKKVQ1>; Mon, 11 Nov 2002 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSKKVQ1>; Mon, 11 Nov 2002 16:16:27 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:14079 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261349AbSKKVQ0>;
	Mon, 11 Nov 2002 16:16:26 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15824.8030.745186.6665@napali.hpl.hp.com>
Date: Mon, 11 Nov 2002 13:21:34 -0800
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Mario Smarduch '" <cms063@email.mot.com>,
       "'davidm+AEA-hpl.hp.com '" <davidm@hpl.hp.com>,
       "'Mario Smarduch '" <CMS063@motorola.com>,
       "'linux-ia64+AEA-linuxia64.org '" <linux-ia64@linuxia64.org>,
       "'linux-kernel+AEA-vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: +AFs-Linux-ia64+AF0- reader-writer livelock proble 
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F4F7@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4F7@usslc-exch-4.slc.unisys.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Nov 2002 14:36:38 -0600, "Van Maren, Kevin" <kevin.vanmaren@unisys.com> said:

  Van> I have not looked at this, but I don't believe it is the right
  Van> way to solve the problem: users who +AF8-need+AF8- to use all
  Van> the CPUs for computation would be punished just to work around
  Van> a kernel implementation issue: that's like saying don't allow
  Van> processes to allocate virtual memory because if the VM is
  Van> over-committed by X amount the kernel deadlocks.

  Van> It would be a bad hack to limit the system-call rate just to
  Van> prevent livelock.

Certainly.  I didn't suggest PRM as a way to _solve_ the livelock
problem, but since Mario asked for a method to cap CPU utilization, I
mentiond it.

	--david
