Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVGVPSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVGVPSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVGVPSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:18:33 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:17416 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261253AbVGVPSd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:18:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TtvBuU7ab2E+rNtGIpVA7Q0CouCKEJM0UafadnAIPuFH8iLO7y4NQKN90Q/3z8BANfkl0FlygNHabLi9VD3rVlH1bSpegvPCwNAgeZUnlmQ4fMTW3/ZSVgS8e3+HyXp3fFCNwG1p/ZGN8sPcFtMj54ykxN/ZaQ9hOg48qTpPXvo=
Message-ID: <3faf0568050722081890a2e@mail.gmail.com>
Date: Fri, 22 Jul 2005 20:48:30 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7d15175e050722072727a7f539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf0568050721232547aa2482@mail.gmail.com>
	 <7d15175e050722072727a7f539@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>
> The location of the vsyscall page is different on 32 and 64 bit
> machines. So 0xffffe000 is NOT the address you are looking for while
> dealing with the 64 bit machine.  Rather 0xffffffffff600000 is the
> correct location (on x86-64).
>
Both my process's are 32-bit process's, its just one runs on 64-bit
machine and other runs on 32-bit machine. The write from address
0xffffe0000 to a file on a 32-bit machine fails, but does'nt fail on
64-bit machine (the process is still 32-bit although it runs on
64-bit).

How can the virtual address of   0xffffffffff600000 exist in a 32-bit
process ? (May be I have not made myself clear in explaining the
problem?? :-?)

Best,
Vamsi.
