Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUEWSdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUEWSdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUEWSdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:33:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16605 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263309AbUEWSdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:33:35 -0400
Message-ID: <40B0EE6C.70400@pobox.com>
Date: Sun, 23 May 2004 14:33:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl>
In-Reply-To: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Linus Torvalds <torvalds@osdl.org> said:
> 
>>Hmm.. This is stuff all over the map, but most interesting (or at least
>>most "core") is probably the merging of the NUMA scheduler and the anonvma
>>rmap code. The latter gets rid of the expensive pte chains, and instead
>>allows reverse page mapping by keeping track of which vma (and offset)  
>>each page is associated with. Special kudos to Andrea Arcangeli and Hugh
>>Dickins.
>>
>>		Linus
> 
> 
> Not wanting to start a flamewar, but this sort of massive changes in a
> _stable_ series has got me quite confused... either 2.6.0 was premature, or
> the "just stabilize 2.6, new stuff only into 2.7 (when it opens)" got lost
> somewhere.


Linux has a tradition of completely rewriting the VM in the middle of a 
stable series, why not again?  :)

/me is joking, but similarly annoyed...

The VM, like the rest of the kernel, will _always_ be a work in 
progress.  A stable series should freeze us for bug fixing and 
stabilization...

	Jeff


