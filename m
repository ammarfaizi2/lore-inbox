Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVEYFWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVEYFWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVEYFWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:22:12 -0400
Received: from graphe.net ([209.204.138.32]:47775 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262274AbVEYFWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:22:06 -0400
Date: Tue, 24 May 2005 22:21:58 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <4293B292.6010301@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505242221340.7191@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
 <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com>
 <Pine.LNX.4.62.0505201210460.390@graphe.net> <428E56EE.4050400@us.ibm.com>
 <Pine.LNX.4.62.0505241436460.3878@graphe.net> <4293B292.6010301@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Matthew Dobson wrote:

> No...  It does compile with that trivial patch, though! :)
> 
> -mm2 isn't booting on my 32-way x86 box, nor does it boot on my PPC64 box.
>  I figured -mm3 would be out shortly and I'd give the boxes another kick in
> the pants then...

Umm.. How does it fail? Any relationship to the slab allocator?

