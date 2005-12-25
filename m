Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVLYLmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLYLmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 06:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLYLmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 06:42:52 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:28350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750709AbVLYLmw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 06:42:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fxk3lnJN1g2ad5jlKIuOKCP4lw28SS08n/93xQUjjaKlSaGnYbtVg+u3zrGl9JIJtFkFuU2dgQEyGL575uE9Lnt1M/UGmTI1Vwkco5tvPGP1sxt2nPcLMD5UdompXazGMglTKTEVcfVFWnMbLxKjK1Z/vNrQOKw+4pzBaJzyMgI=
Message-ID: <5a3ed5650512250342s60f507ffrbff1688bab82c1b0@mail.gmail.com>
Date: Sun, 25 Dec 2005 14:42:50 +0300
From: regatta <regatta@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>,
       Wichert Akkerman <wichert@wiggy.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: FS possible security exposure ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1135505852.2946.12.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
	 <1135503601.2946.6.camel@laptopd505.fenrus.org>
	 <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
	 <1135505852.2946.12.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all, it was great information that you shared with me



On 12/25/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2005-12-25 at 13:10 +0300, regatta wrote:
> > I'm using Vi in Solaris and Vim in Linux, do you think this is the
> > problem ?
>
> that very well can be the difference
>
> > but if you think about it, how could the system allow the user to
> > modify a file that he don't own it and he don't have write privilege
> > on the file just because he has write in the parent directory ?
> >
> > Maybe I'm wrong, but is this normal ? please let me know
>
> this is normal and a result of the linux permission model.
> (and fwiw you don't get to edit the file, only to create a new file. You
> may think that's exactly the same.. but it's not in the light of
> hardlinks)
>
> Btw there is a "sticky bit" you can set on the directory which changes this behavior,
> for example /tmp has this set for obvious reasons
>
> > BTW: is there any document, article or any page about this so I can
> > show it to my boss :)
>
> I suspect the SUS standard fully specifies the 4 rules I mentioned and
> the sticky-exception (and the rest is an obvious result)
>
>
>


--
Best Regards,
--------------------
-*- If Linux doesn't have the solution, you have the wrong problem -*-
