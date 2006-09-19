Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWISACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWISACv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWISACv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:02:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:882 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030316AbWISACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:02:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UPZHAh0NTVG1L8T/OCvVbU3e7NtUpqoj2s67KbDSC9dYbJlGeJbM//+SXE5M+d2x0RQCnxjjzDUs2T/9Z5dBYs+APcP+RBwnLCSLZMKx2bxJ8monGyefKYQnUdT3b7yitN1v11gF5zn5ewVgFlE9q7jrtrdPwFQfKKqUIKTwm18=
Message-ID: <9a8748490609181702r6a6bac4et560081e2a25adc1f@mail.gmail.com>
Date: Tue, 19 Sep 2006 02:02:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: sergio@sergiomb.no-ip.org
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
In-Reply-To: <1158623391.13821.4.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <1158623391.13821.4.camel@localhost.portugal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/06, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:
> On Tue, 2006-09-19 at 00:18 +0200, Jesper Juhl wrote:
> > Hi,
> >
> > If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> > tried this with) and then boot the kernel with "no387" then I only get
> > as far as lilo's "...Booting the kernel." message and then the system
> > hangs.
> >
>
> I think, math emulation is for 486 and older. 486 DX2 was the first one
> who have math co processor, on earlier processor it should be disable .
>
Yes, it's mainly there for CPU's that don't have a math co-processor,
but it's also there for the cases where the math co-processor is
broken or where for some other reason you may not want to use it - so
it really should work...  Sure, it may be slow as hell compared to
hardware, but if it's there and I can select it then it should at
least be functional.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
