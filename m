Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbULPWsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbULPWsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbULPWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:45:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1153 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262053AbULPWok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:44:40 -0500
Message-ID: <41C20FFF.6000004@tmr.com>
Date: Thu, 16 Dec 2004 17:45:19 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
References: <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk><E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk> <20041215114916.GB1232@elf.ucw.cz>
In-Reply-To: <20041215114916.GB1232@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Okay, what about this one:
> 
> You merge xen hooks in mainline, but keep maintaining arch/xen
> out-of-tree? You have to maintain it yourself, anyway, and having
> hooks merged should make it easy.
> 
> When xen is merged into i386 (you said that is your long-term goal
> anyway), you can merge that into mainline...
> 							Pavel

Assuming this is practical and would let xen get exposure sooner rather 
than later, it would be nice if the hooks could be used for other 
projects. My impression is that the merge part would come after there is 
some extensive experience with the operation "in the wild" so to speak. 
Who knows what operating systems might run in this way.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
