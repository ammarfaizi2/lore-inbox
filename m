Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbULPVkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbULPVkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbULPVkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:40:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262029AbULPVjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:39:42 -0500
Date: Thu, 16 Dec 2004 16:39:26 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-Reply-To: <E1Cf3Ib-0006dM-00@mta1.cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0412161639000.26850@chimarrao.boston.redhat.com>
References: <E1Cf3Ib-0006dM-00@mta1.cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Ian Pratt wrote:
>> Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
>>>
>>> I'm not convinced that maintaining xen/i386 in its current form
>>>  is going to be as hard as Andi thinks. We already share many
>>>  files unmodified from i386.
>>
>> How are they shared?  Inclusion, symlinks, makefile references or
>
> The makefile creates symlinks.

Which is really very nice.  If you update arch/i386/ then
arch/xen/ automatically gets the update too.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
