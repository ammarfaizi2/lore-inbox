Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWILUqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWILUqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWILUqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:46:38 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:456 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030431AbWILUqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daJH/WWmiJosQT1VjaqYTGQNtOsXD/daLefvUMfqPOdlFvR47xRDqxfCBDUSphmIdfHS78T9+y1jdzVkw+BTR65sJu2dy/NXXweNATKW/2wbE47UciBg6Wm/u3OnEvTv5h2Z5tG1SdGaozB2LrNa3xsvo06Q80Bsjxjt8Yt7P+s=
Message-ID: <653402b90609121346n51af4aadi32f8f1e9e4004b8c@mail.gmail.com>
Date: Tue, 12 Sep 2006 22:46:03 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: OT: calling kernel syscall manually
Cc: "David Woodhouse" <dwmw2@infradead.org>, guest01 <guest01@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <450717A5.90509@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4506A295.6010206@gmail.com>
	 <1158068045.9189.93.camel@hades.cambridge.redhat.com>
	 <450717A5.90509@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> What do you mean you have removed the ability to make system calls
> directly?  That makes no sense.  Glibc has to be able to make system
> calls so you can write your own code that does the same thing if you want.
>

Well, they removed the EXPORT_SYMBOL_GPL(sys_call_table);

http://www.cs.helsinki.fi/linux/linux-kernel/2003-18/0173.html

You can still found syscall addresses with some "tricks".
