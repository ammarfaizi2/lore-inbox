Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJPRlg>; Wed, 16 Oct 2002 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJPRlg>; Wed, 16 Oct 2002 13:41:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12270 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261290AbSJPRle>; Wed, 16 Oct 2002 13:41:34 -0400
Date: Wed, 16 Oct 2002 10:41:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux v2.5.43
Message-ID: <90940000.1034790104@flay>
In-Reply-To: <2115024384.1034726455@[10.10.2.3]>
References: <3DACEDE0.7FB25F02@digeo.com> <2115024384.1034726455@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> A huge merging frenzy for the feature freeze,
>> 
>> Doesn't compile on ia32 uniprocessor.  The owner of
> 
> Arrgh. I booted that on my UP test box (it's still running). 
> I must have forgotten to do the fifth patch on that one or 
> something equally stupid.

OK, went back and checked my testing method - it only breaks if
you have Uniproc with IO-APIC support, which I didn't test 'cause
I knew it was broken anyway (yeah, I still should have caught that).

Now I feel *slightly* less stupid ;-)
 
>> changeset 1.852 is hereby debited 31 CPUs.
> 
> /me hands them over.

Well, maybe half of them, all things considered ;-)
Here, have 15.5 CPUs ;-)

Thanks for the patch,

M.

