Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVERVPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVERVPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVERVPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:15:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62350 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262376AbVERVPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:15:17 -0400
Message-ID: <428BB05B.6090704@us.ibm.com>
Date: Wed, 18 May 2005 14:15:07 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Christoph Lameter <christoph@lameter.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 18 May 2005, Matthew Dobson wrote:
> 
> 
>>Thanks!  I just looked at V2 & V3 of the patch and saw some open-coded
>>loops.  I may have missed a later version of the patch which has fixes.
>>Feel free to CC me on future versions of the patch...
> 
> 
> I will when I get everything together. The hold up at the moment is that 
> Martin has found a boot failure with the new slab allocator on ppc64 that 
> I am unable to explain.
>  
> Strangely, the panic is in the page allocator. I have no means of 
> testing since I do not have a ppc64 system available. Could you help me 
> figure out what is going on?

I can't promise anything, but if you send me the latest version of your
patch (preferably with the loops fixed to eliminate the possibility of it
accessing an unavailable/unusable node), I can build & boot it on a PPC64
box and see what happens.

-Matt
