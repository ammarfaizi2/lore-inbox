Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWJMRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWJMRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWJMRvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:51:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:30140 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751757AbWJMRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:51:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WUKHPrB3o+5Q5V8nA4sBJx4/4SqrnTj5Se1pHBsSJiNM4o5w8om/OASQQZKXiL1xfEn8P1JN04YV3jbcHVHMz07JL2IYrQkjxFh6ExSviw4jQtNclgrmdPQQaY33mxtBCQa1eEvyttfsE3vBf5eJLbsejaq6JBDpNWVcSee6OQE=
Message-ID: <28bb77d30610131051p167c967jfdd3b246b466d86f@mail.gmail.com>
Date: Fri, 13 Oct 2006 10:51:11 -0700
From: "Steven Truong" <midair77@gmail.com>
To: "Jean-Marc Saffroy" <saffroy@gmail.com>
Subject: Re: [Crash-utility] Re: kdump/kexec/crash on vmcore file
Cc: "Vivek Goyal" <vgoyal@in.ibm.com>, linux-kernel@vger.kernel.org,
       crash-utility@redhat.com
In-Reply-To: <Pine.LNX.4.64.0610131727270.4785@erda.mds>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
	 <20061013141446.GA27375@in.ibm.com>
	 <Pine.LNX.4.64.0610131727270.4785@erda.mds>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Jean-Marc.  I am going to try your tool too.

On 10/13/06, Jean-Marc Saffroy <saffroy@gmail.com> wrote:
> Steven,
>
> I see you tried using gdb, maybe a tool I wrote could help you:
>    http://jeanmarc.saffroy.free.fr/kdump2gdb/
>
> Basically it will convert the kdump core to a slightly different core that
> is suitable for gdb, as well as a gdb script that loads kernel modules at
> the right offsets. Then maybe you can grab a backtrace of the faulting
> process ("bt full" can be nice) and post it to l-k.
>
>
> Cheers,
>
> --
> saffroy@gmail.com
>
