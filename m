Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVIHOzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVIHOzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVIHOzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:55:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15325 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932519AbVIHOza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:55:30 -0400
Date: Thu, 8 Sep 2005 07:55:13 -0700
From: Paul Jackson <pj@sgi.com>
To: dipankar@in.ibm.com
Cc: dino@in.ibm.com, kurosawa@valinux.co.jp, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050908075513.26c8c2d5.pj@sgi.com>
In-Reply-To: <20050908141152.GA11793@in.ibm.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
	<20050908131427.GA5994@in.ibm.com>
	<20050908141152.GA11793@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar wrote:
> If what subcpusets is doing is slicing cpusets resources, then wouldn't
> it be more intusive to call them slice0, slice1 etc. under the 
> respective cpuset ?

If we continue with Takahiro-san's design, then I agree that the name
'subcpusets' doesn't have quite the right connotations, and would join
you in exploring alternative names.

First it looks to be worth exploring alternatives that make resource
control more an attribute of existing cpusets than a new (sub) type of
cpuset, as Dinakar and I have both contemplated in earlier posts today.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
