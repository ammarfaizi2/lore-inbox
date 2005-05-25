Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVEYSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVEYSir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVEYSaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:30:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21199 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262383AbVEYS1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:27:46 -0400
Message-ID: <4294C39B.1040401@us.ibm.com>
Date: Wed, 25 May 2005 11:27:39 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com> <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com> <Pine.LNX.4.62.0505201210460.390@graphe.net> <428E56EE.4050400@us.ibm.com> <Pine.LNX.4.62.0505241436460.3878@graphe.net> <4293B292.6010301@us.ibm.com> <Pine.LNX.4.62.0505242221340.7191@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505242221340.7191@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 24 May 2005, Matthew Dobson wrote:
> 
> 
>>No...  It does compile with that trivial patch, though! :)
>>
>>-mm2 isn't booting on my 32-way x86 box, nor does it boot on my PPC64 box.
>> I figured -mm3 would be out shortly and I'd give the boxes another kick in
>>the pants then...
> 
> 
> Umm.. How does it fail? Any relationship to the slab allocator?

It dies really early om my x86 box.  I'm not 100% sure that it is b/c of
your patches, since it dies so early I get nothing on the console.  Grub
tells me it's loading the kernel image then....  nothing.

-Matt
