Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285213AbRLXSYM>; Mon, 24 Dec 2001 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285216AbRLXSYC>; Mon, 24 Dec 2001 13:24:02 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:7614 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285213AbRLXSXq>; Mon, 24 Dec 2001 13:23:46 -0500
Message-ID: <3C2772B1.3080202@redhat.com>
Date: Mon, 24 Dec 2001 13:23:45 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <Pine.LNX.4.40.0112240951030.24605-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> so this just means that an eye needs to be kept on the non-dynamic
> syscalls  and up the starting point for dynamic syscalls significantly
> before we run out of space for the non-dynamic ones.
> 
> running software that depends on features in a new kernel on a
> significantly older kernel is always questionable, if you software really
> needs to do that you need to watch for a bunch of things.


No.  This is different.  Calling a syscall and expecting to get either A) 
the syscall you intended or B) -ENOSYS is an accepted, safe practice under 
Unix/Linux.  This breaks that practice.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

