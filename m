Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUJCDhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUJCDhh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUJCDhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:37:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60569 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267702AbUJCDhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:37:35 -0400
Date: Sat, 2 Oct 2004 20:35:21 -0700
From: Paul Jackson <pj@sgi.com>
To: dipankar@in.ibm.com
Cc: akpm@osdl.org, nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002203521.4b43ed8c.pj@sgi.com>
In-Reply-To: <20041002145521.GA8868@in.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar wrote:
> For this to succeed, they need to be completely
> isolated.

Do you mean by completely isolated (1) running two separate system
images on separate partitions connected at most by networks and storage,
or do you mean (2) minimal numa interaction between two subsets of
nodes, all running under the same system image?

If (1), then the partitioning project is down the hall ;)  But I guess
you knew that.  The issues on this thread involve managing resource
interactions on a single system image.

Just checking ... the words you used to describe the degree of
separation were sufficiently strong that I became worried we were at
risk for a miscommunication.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
