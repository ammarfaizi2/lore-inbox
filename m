Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161369AbWJ3SzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWJ3SzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161364AbWJ3SzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:55:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:11169 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161366AbWJ3SzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:55:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zc8LlZ9fx9BC3Ve1vCWqF+kOzcg3qAyYu4pYGzTaj8AFtUsyIDukOvZp3jjlggQdpYCrFlBdfAiWGqZ1S+i73wFICGpLe4u1wWnAf4G6jGr2gzP3Vg4COWcYGPtAQRwrdD+l/yHd+y/lTlV3Pf9zrHxlm8xjRqQwZf/bX9B4Byc=
Message-ID: <5a4c581d0610301055m376bd1eao396c8f4566a79654@mail.gmail.com>
Date: Mon, 30 Oct 2006 19:55:09 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: loading EHCI_HCD slows down IDE disk performance by 50%
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1162223291.14733.119.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
	 <1162146560.14733.65.camel@mindpipe>
	 <5a4c581d0610291152r7f538188m4ce52fba1f5f4683@mail.gmail.com>
	 <1162223291.14733.119.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-10-29 at 20:52 +0100, Alessandro Suardi wrote:
> > On 10/29/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Sun, 2006-10-29 at 19:13 +0100, Alessandro Suardi wrote:
> > > > Any hints/tips about what to try with this issue will be
> > > >  of course very welcome.
> > >
> > > git bisect
> >
> > As I clarified to Lee in private email, this method doesn't
> >  seem to apply in this situation, as the problem appeared
> >  when I selected CONFIG_EHCI_HCD in my build due to the
> >  purchase of the USB2.0 disk, back in the 2.6.16-rc cycle;
> >  so if the combination of high performance IDE + EHCI_HCD
> >  ever existed, it must be earlier than 2.6.16-rc5-git8.
> >
> > Lacking any input I'll try to find out more in the next week
> >  by starting out at 2.6.10 and eventually earlier.
>
> Maybe you could close the Bugzilla ticket you posted, as most of the
> comments relate to HAL and polling for media changes which you seem to
> be saying have nothing to do with this bug?

The bugzilla entry was hijacked by people who were incorrectly
 thinking their problem had to do with my report, I myself have
 always stated HAL/polling had nothing to do with the issue. Not
 my fault, there...

I may of course re-file the bug, but it'd be nice if I were asked
 by someone looking after the Fedora bugzilla; as a matter of
 fact I did ask for opinions there after my last findings.

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
