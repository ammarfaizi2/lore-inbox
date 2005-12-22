Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVLVHPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVLVHPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVLVHPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:15:47 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:10631 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965103AbVLVHPr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:15:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rabF9Hd+FzmMZB2IiH4roHDNzbg9Y0RyoYwH8Ss8X7JwA1faOf4ayC1V3kwYeTGoa8IzQQrbU7fyaB8d1I+q1nU2kB20oOtw0le7lexLbtIVDeKfrPV1938Jdw5QQFFui5OLiBVNZ973ZTeB69hjdmE7c2mHZp6/se73u7ghdy4=
Message-ID: <6f48278f0512212315n24301308ia81fc8094fc93838@mail.gmail.com>
Date: Thu, 22 Dec 2005 15:15:43 +0800
From: Jie Zhang <jzhang918@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Question on the current behaviour of malloc () on Linux
Cc: linux-kernel@vger.kernel.org, lars.friedrich@wago.com
In-Reply-To: <9a8748490512211005u40ca4c7dv41044827544f97fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
	 <9a8748490512211005u40ca4c7dv41044827544f97fa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/21/05, Jie Zhang <jzhang918@gmail.com> wrote:
> > Hi,
> >
> > I first asked this question on uClinux mailing list. My first question
> > is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
> > Although I found this issue on uClinux, it's also can be demostrated
> > on Linux. This is a small program:
> >
> [snip memory hog]
> >
> > When I run it on my Linux notebook, it will be killed. I expect to see
> > it prints out   "fail".
> >
>
> You are seeing the effects of Linux overcommitting memory.
>
[snip]
>
> For more information read Documentation/vm/overcommit-accounting ,
> Documentation/sysctl/vm.txt & Documentation/filesystems/proc.txt
>
Thanks a lot! Your explaination is very detailed and easier to
understand than the doc for me.

Best Regards,
Jie
