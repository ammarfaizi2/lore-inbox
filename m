Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbULADkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbULADkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 22:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULADkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 22:40:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18163 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261207AbULADkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 22:40:46 -0500
Message-ID: <41AD3D3B.1020509@mvista.com>
Date: Tue, 30 Nov 2004 19:40:43 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: A problem with xconfig
References: <41ABA8E5.4060504@mvista.com> <20041130052824.GA8211@mars.ravnborg.org> <41AC4C1D.1050102@mvista.com> <20041130193136.GB8777@mars.ravnborg.org>
In-Reply-To: <20041130193136.GB8777@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Nov 30, 2004 at 02:31:57AM -0800, George Anzinger wrote:
> 
>>>It used to be so but was addressed in a patch to scripts/kconfig/Makefile
>>>a few weeks ago. Do you see it with latest -linus / -mm?
>>
>>Gosh, did I do that.  Forgot to say it was the 2.6.9 kernel.  Am I the only 
>>one using xconfig??
> 
> No - but the fault only happens when you are starting from a fesh tree.
> Running mrporper would not delete the old .so file (kbuild 'lost' knowledge
> of it). So most people have just untarred a new kernel on top
> of the old one and it still worked.

Yeah, we are using "quilt" in a big way now and it like to start with new trees.

> 
> Also the reason why I failed to fix it in the first place. xconfig and gconfig
> worked even after mrproper - because the .so file survived.
> 
> 	Sam
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

