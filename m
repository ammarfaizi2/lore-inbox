Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUIIDJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUIIDJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUIIDJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:09:36 -0400
Received: from holomorphy.com ([207.189.100.168]:21677 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269243AbUIIDJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:09:35 -0400
Date: Wed, 8 Sep 2004 20:09:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040909030916.GR3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ray Bryant <raybry@sgi.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
	piggin@cyberone.com.au
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413FC8AC.7030707@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:06:20PM -0500, Ray Bryant wrote:
> For what it is worth, here are the benchmark results for the kernel with 
> the patch I discussed before, along with the previous 2.6.9-rc1-mm3 results:
[...]
> Except for the swappiness = 20 case, things are a smallish bit better for
> the modified kernel than 2.6.9-rc1-mm3.  Clearly we haven't found the root 
> of this problem yet.
> Have you still been unable to duplicate this problem on a small i386 
> platform?

Please log periodic snapshots of /proc/vmstat during runs on kernel
versions before and after major behavioral shifts.


-- wli
