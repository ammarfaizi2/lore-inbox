Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUA0Vtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUA0Vtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:49:50 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52409 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265649AbUA0Vtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:49:45 -0500
Message-ID: <4016DD62.7020905@namesys.com>
Date: Tue, 27 Jan 2004 13:51:30 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Halcrow <mike@halcrow.us>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Filesystem
References: <16405.24299.945548.174085@laputa.namesys.com> <40156449.8010805@namesys.com> <4016B444.A816C980@namesys.com> <20040127212546.GA10831@halcrow.us>
In-Reply-To: <20040127212546.GA10831@halcrow.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow wrote:

>
>  I am
>aware of reiser4; Hans may remember having lunch with me at the
>DISCEX-III conference in Washington, D.C. last year.  My booth (the
>BYU Internet Security Research Lab; Trust Negotiation) was right
>across from his:
>
>http://csdl.computer.org/comp/proceedings/discex/2003/1897/02/1897toc.htm
>
>He had a lengthy discussion with Jason Holt[2] on the implementation
>of crypto in reiser4.
>
>While I appreciate the security features that are part of reiser4, my
>efforts toward filesystem encryption are aimed at a more general
>level, to provide an encryption layer that will work across several
>filesystems.  Perhaps we can look into unifying and abstracting the
>key management, authentication, and other aspects involved in a
>comprehensive filesystem encryption system, extending and using kernel
>structures (struct file, kobject/sysfs, etc.) to maintain that data,
>so whether someone is using reiser4, Security Enhanced ext3 (SEext3),
>or Security Enhanced jfs (SEjfs)[3], the interface to userland will be
>the same.
>  
>
I am in principle interested in doing this, especially since the area of 
our inspiration is not in key management but in performance.

>
>[2] Hans: Jason was a co-worker of mine in the ISRL, skinny and tall
>with curly red hair (he's hard to forget once you've met him:
><http://isrl.cs.byu.edu/images/Dcp02290.jpg>)
>  
>
Jason is working on a write only plugin (or at least he said so a few 
months ago) for reiser4.  You probably remember him discussing it then.  
Where is your photo, or are you a CIA spy who needs to keep it 
secret....;-)  I remember three interesting people talked to me all at 
once at that conference about reiser4 crypto and other things that crept 
into that conversation, if you send your photo I can know if I remember 
correctly which one other than Jason you were.

>[3] That was meant to be funny...
>.___________________________________________________________________.
>                         Michael A. Halcrow                          
>       Security Software Engineer, IBM Linux Technology Center       
>GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
>  
>


