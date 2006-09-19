Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWISWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWISWoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWISWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:44:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:25209 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751171AbWISWoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:44:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cWmaKaB1ht7RF5c0oHpoboS/Zf/tyxoeWk65rxiD3xIAKTiJeymDzWqW2BHy70R3Sfq4CE7RgJuam5Y3azRRRIB6Ep4gIsQTvdfKJgG4iuhaA429KeeZFlRIHXTlk91YnWD73AqUyvVQ14KL5y/3N3LSf9QEI1Uhj1PjF5CU0IA=
Message-ID: <9a8748490609191544r6f05ca27wd383356ce36cf465@mail.gmail.com>
Date: Wed, 20 Sep 2006 00:44:15 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490609191516x4305c67dy76ac742e92f08ced@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <p73venk2sjw.fsf@verdi.suse.de>
	 <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	 <9a8748490609191516x4305c67dy76ac742e92f08ced@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 20/09/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> > On Tue, 19 Sep 2006, Jesper Juhl wrote:
> > >
> > > The config is attached.
> >
> > Can you try without SMP, and with CONFIG_X86_GENERIC
>
> Done. The result is exactely the same as before. The kernel boots and
> runs just fine except when I add "no387" to the boot options, then it
> hangs.
>
I just tried building the kernel for 486 as well - no luck with
"no387" with that one either.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
