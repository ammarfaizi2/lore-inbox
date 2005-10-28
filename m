Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVJ1HTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVJ1HTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVJ1HTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:19:11 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:9279 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965136AbVJ1HTK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:19:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xjj8yuW7hVpSZCTBXrYcwlEnhVaWG44HzuxaBCXREH1OeH309bJkSrXndEffQGZG8D5XI4ar2sFRo2Xy+4PiPs49yTjgmnsQIQ2pkzB7I8L6JImSvS1v0avo0m7XMgTeBOk4oqRfvoP7xunznQUaA6WqHxdoVYHF9Pofl9Ks9Ww=
Message-ID: <1e62d1370510280019o206be344kc2fbf4cc31ccfabd@mail.gmail.com>
Date: Fri, 28 Oct 2005 12:19:09 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Subject: Re: 4GB memory and Intel Dual-Core system
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510271947360.32301@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org>
	 <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org>
	 <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
	 <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
	 <Pine.LNX.4.64.0510271947360.32301@twin.uoregon.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Joel Jaeggli <joelja@darkwing.uoregon.edu> wrote:
> On Fri, 28 Oct 2005, Fawad Lateef wrote:
>
> > Can you tell me the main differences between IA64 and x86_64 (Opteron)
>
> IA64 is itanium - there are a lot of differences but the principle one for
> your perspective is that you don't want to run x86 code on a itanium, it
> has an x86 instruction decoder but you wouldn't want to use it if you
> could avoid it.
>

OK

> > ? because in your one of the previous mail you said IA64 != EM64T and
>
> emt64 getts lumped with amd64 collectivly x86_64. fundamentaly intels
> implementation is compatible with amd's
>
> > its true, but I know is EM64T/AMD64 in 64-bit mode != IA32 but you
> > said that too EM64T is not really 64-bit, its a IA32 .. Can you give
>
> It is ia32 except with 40 bits of real memory and 48 bits of virtual
> memory and 64 bit registers.
>

And a difference of memory architecture is there tooo. x86_64 in
64-bit mode implements flat memory model but IA32 uses
segmentation/paging. As far as Linux Kernel is concern I know kernel
won't implements segmentation in IA32 so it memory management is
almost compatible with x86_64 except registers/real address /virtual
addresses ...

> one article that's use for getting a start on the instruction set is here:
>
> http://arstechnica.com/cpu/03q1/x86-64/x86-64-1.html
>

Thanks, nice link :)

>
> > me some link which just tells the difference between IA64 (Itanium)
> > and AMD64 (Opteron) ?
>
> you're not likely to care about ia64, so I think what your'e really
> interested in is ia32 vs x86_64 and intel vs amd in the context of x86_64
>

Nops, I am not interested in x86_64 context of intel and amd, I rather
wanted a comparison between the intel and amd server processors
architecture (Itanium and Opteron).

Any ways, Thanks


--
Fawad Lateef
