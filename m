Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUHGGqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUHGGqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 02:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUHGGqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 02:46:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21651 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266174AbUHGGqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 02:46:03 -0400
Date: Fri, 6 Aug 2004 23:45:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: mbligh@aracnet.com, efocht@hpce.nec.com, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040806234529.38024b52.pj@sgi.com>
In-Reply-To: <4113A860.4070007@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<267050000.1091806507@[10.10.2.4]>
	<4113A860.4070007@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus asked:
> While we are on the topic, do you envision these sets to be somewhat 
> hierarchical or simply a flat hierarchy ?

I'm not sure what you mean by the distinction between a "somewhat"
hierarchy and a "simply flat" hierarchy ... I'll guess you're asking how
deep we envision these sets being.

I'd envision they start out just one or two deep, then over time they
tend to reflect the several layer deep organizational structure of the
institution paying for the big iron, _plus_ another layer or two to
handle the cpu/memory placement needs of more complex applications.

With occassional examples a few times that.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
