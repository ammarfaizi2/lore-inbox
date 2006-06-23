Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932903AbWFWHQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbWFWHQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbWFWHQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:16:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:29614 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932903AbWFWHQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:16:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EHUbU6v/vLY8jm5d2layhiPSM/jJJ59FAkc4qfBfqmVxTzmrPXv8mPbqwIiEuK35JXUXq6XbL5bYTrbU46A2wfldOs1Ti02BS3ZLKOtOdkHRwx5QMrgzZw2K40MReR76nnasBVRsqRG2VNF8N9ZKnGC9psM9+PhQdGVw2m/QQFg=
Message-ID: <449B9309.2040102@gmail.com>
Date: Fri, 23 Jun 2006 09:06:49 +0200
From: "scientica (GMail)" <scientica@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: kubisuro@att.net
CC: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: problem burning DVDs with 2.6.17-ck1 (mlockall?)
References: <449B52BF.3070404@pcisys.net> <449B7430.80503@att.net>
In-Reply-To: <449B7430.80503@att.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan M. wrote:
> Hello,
>
> Brian Hall wrote:
>> After upgrading from 2.6.16-ck11 to 2.6.17-ck1, I find I can no longer
>> burn DVDs. With growisofs I get:
> <snip>
>> Maybe it's something else I've done on the system. Running ~amd64 Gentoo
>> 2006.0. Suggestions welcome!
>>
>
> I have not had any problems burning DVDs with 2.6.17-ck1 using an ix86 
> kernel.
>
> I primarily use k3b which utilizes growisofs.
>
> Perhaps something else in kernel 2.6.17 with regards to x86-64 changed 
> to cause this
> problem?
I'm running 2.6.17-ck1 on this machine (x86-64, single core), I've 
bruned a few DVDs yesterday (using growisofs). My guess is either that 
some SMP thingy causes it (don't think it's likely though), or (and I 
hope you're not using ~amd64 in /etc/make.conf - that *will* break 
things ;) it's some ~amd64 package.
My tools are:
=app-cdr/dvd+rw-tools-5.21.4.10.8  # (<- this one provies growisofs)
=app-cdr/cdrtools-2.01.01_alpha07
other than that the only thing I can think of right now would be "need 
to be root" (or something like g+rw for the dvd-device)
>
> regards,
> Ryan M.
Cheers
Fredrik
>
> _______________________________________________
> http://ck.kolivas.org/faqs/replying-to-mailing-list.txt
> ck mailing list - mailto: ck@vds.kolivas.org
> http://vds.kolivas.org/mailman/listinfo/ck
>


-- 
After all, if you are in school to study computer science, then a professor
saying "use this proprietary software to learn computer science" is the
same as English professor handing you a copy of Shakespeare and saying
"use this book to learn Shakespeare without opening the book itself."
  -- Bradley Kuhn

