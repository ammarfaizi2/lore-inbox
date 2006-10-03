Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWJCFnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWJCFnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWJCFnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:43:04 -0400
Received: from sandeen.net ([209.173.210.139]:4408 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S965258AbWJCFnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:43:01 -0400
Message-ID: <4521F865.6060400@sandeen.net>
Date: Tue, 03 Oct 2006 00:43:01 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       esandeen@redhat.com
Subject: Re: 2.6.18 ext3 panic.
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com>
In-Reply-To: <20061003052219.GA15563@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> So I managed to reproduce it with an 'fsx foo' and a
> 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
> a vanilla 2.6.18 with none of the Fedora patches..
> 
> I'll give 2.6.18-git a try next.
> 
> 		Dave
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at fs/buffer.c:2791

I had thought/hoped that this was fixed by Jan's patch at 
http://lkml.org/lkml/2006/9/7/236 from the thread started at 
http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
first by going through that new codepath....

-Eric
