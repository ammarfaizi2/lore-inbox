Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUHGTBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUHGTBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUHGTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:01:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38862 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264213AbUHGTBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:01:09 -0400
Date: Sat, 7 Aug 2004 11:59:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040807115918.44f43089.pj@sgi.com>
In-Reply-To: <200408071722.36705.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich wrote:
> (and the name cpuset is a bit misleading)

I've just begun reading your reply.  A quick note on the name "cpusets".
Yes, it is a bit misleading.

On SGI's Irix, they are 'cpusets'.  On SGI's 2.4 Linux kernels, the
kernel portion is called 'cpumemsets', and the user support 'cpusets'. 
Independently, Simon of Bull chose 'cpusets'.  For a while, I was
lobbying Simon to change it to 'cpumemsets', then I decided to heck with
it, as the shorter, sweeter name seemed to be the more commonly used.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
