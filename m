Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWBJQmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWBJQmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWBJQmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:42:54 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:7132 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751297AbWBJQmy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:42:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DW7WK2xYLaDNMfXnEhrhQ/0Fn75fG+tf/9SUAR1mUAeKIs9NHeTnS/g1XJOWVPpuf9e9lWofkDyuKu5FVJScf1c1AIWuvW8Fzo6+5fxKqQAi5XHCFj0jV1l5tZaNMgOTrOz1LAOfcLnbwwBWnPQWGzxYQR5oBKTqhOtHW2XuKYY=
Message-ID: <1e62d1370602100842k21c4c600h9404cfb034e0deb1@mail.gmail.com>
Date: Fri, 10 Feb 2006 21:42:51 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Ottavio Campana <ottavio@campana.vi.it>
Subject: Re: example of kernel thread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43ECB713.4010908@campana.vi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43ECB713.4010908@campana.vi.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Ottavio Campana <ottavio@campana.vi.it> wrote:
> I'm writing a little driver and I need to run a thread to poll data.
>
> I've googled a bit to find an example, but I only found this
> http://www.scs.ch/~frey/linux/kernelthreads.html
> but it is for 2.4, while I need it for 2.6
>
> Do you know any example and/or tutorial for kernel threads?
>

You can get help from include/linux/kthread.h (its well commented) and
can also take a look at drivers/md/md.c (the md_thread function and
hows kernel_thread is used) !


--
Fawad Lateef
