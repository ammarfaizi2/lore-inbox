Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWE3Ts4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWE3Ts4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWE3Ts4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:48:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:49196 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932449AbWE3Tsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:48:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wh32Hh5kbWs5NjBIS55xKmIbE2HLK7iDQTlBwswwvirbPIvKYOwr6ZZnrP+CFYgA2aHlVuyWgvi7I7EcUT4fBXqsAJn14MfM7C7y00fiLjm2xi8sjwPC4h3V7WbcGGMtOIFD5pdvpomdYbFeu+rPyMjva4/Kxw/NKsHemKZ/qNI=
Message-ID: <6bffcb0e0605301248vbdd68dehdb76dcd44c4df7a@mail.gmail.com>
Date: Tue, 30 May 2006 21:48:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, "Arjan van de Ven" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060530192838.GA22742@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605300916l6e22c814jf9368856f33a9599@mail.gmail.com>
	 <20060530192838.GA22742@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Hi Ingo,
> >
> > On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> > >
> >
> > Here is small lockdep bug
> >
> > May 30 18:05:08 ltg01-fedora ainit:
> > May 30 18:05:09 ltg01-fedora kernel: BUG: warning at
> > /usr/src/linux-mm/kernel/lockdep.c:1853/trace_hardirqs_on()
>
> hm. Do you have the NMI watchdog enabled? [does /proc/interrupts show
> any increasing NMI counts?]

No.

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
