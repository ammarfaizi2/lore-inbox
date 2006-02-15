Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422894AbWBOBBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWBOBBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422906AbWBOBBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:01:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35739 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422894AbWBOBBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:01:12 -0500
Date: Tue, 14 Feb 2006 17:00:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: suresh.b.siddha@intel.com, akpm@osdl.org, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-Id: <20060214170037.6349e0dc.pj@sgi.com>
In-Reply-To: <43F2713E.3080204@bigpond.net.au>
References: <43ED3D6A.8010300@bigpond.net.au>
	<20060214010712.B20191@unix-os.sc.intel.com>
	<43F25C60.4080603@bigpond.net.au>
	<20060214154432.9a4f8a0c.pj@sgi.com>
	<43F2713E.3080204@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hopefully it won't come to that :-).

Agreed.  Sched_setaffinity and cpusets can help here,
by restricting the choices available to the scheduler.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
