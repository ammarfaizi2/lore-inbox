Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTKYQ6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKYQ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:58:40 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:25178 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262176AbTKYQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:58:39 -0500
Date: Tue, 25 Nov 2003 11:58:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-Reply-To: <3FC358B5.3000501@softhome.net>
Message-ID: <Pine.LNX.4.44.0311251158110.2870-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0311251158112.2870@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:

>    2.6: the same as 2.4 with oom killer (default conf). I have no test
> system to check 2.6. w/o oom killer.

# echo 2 > /proc/sys/vm/overcommit_memory

Then try again.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

