Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVEMH0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVEMH0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVEMH0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:26:03 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:10346 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVEMHZ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:25:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JkWWrZwRfNwq3oucyKIrBFP8+UkKu0cFMbxblCsplRh/O8qU0WzBr0BEwbmLVqMvImeCWpBrcFnLQ1jIPjyesGKGezeWW/zw9ltCaja3JYDf+0dzEl0XBtpB3sqt3KOSfo6WXynHLI3OmF0ssDiQagRuE7g4nY/IcRNWbWQ6Dbk=
Message-ID: <21d7e99705051300252cadf24a@mail.gmail.com>
Date: Fri, 13 May 2005 17:25:55 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21d7e99705051300247ce20c5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050512033100.017958f6.akpm@osdl.org>
	 <21d7e99705051300247ce20c5a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ends with:
>   CC      mm/hugetlb.o
> /foo/airlied/git/linux-good/linux-2.6.12-rc4/mm/hugetlb.c: In function
> `enqueue_huge_page':
> /foo/airlied/git/linux-good/linux-2.6.12-rc4/include/linux/mm.h:500:
> sorry, unimplemented: inlining failed in call to 'page_zone': function
> not considered for inlining
> /foo/airlied/git/linux-good/linux-2.6.12-rc4/mm/hugetlb.c:486: sorry,
> unimplemented: called from here
> make[2]: *** [mm/hugetlb.o] Error 1
> 

off course then I find the patch from Adrian Bunk that fixes it ..

Dave.
