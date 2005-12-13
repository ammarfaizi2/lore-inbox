Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVLMS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVLMS7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVLMS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:59:21 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:1971 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932447AbVLMS7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:59:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=axaMxuOwdtG5vcZ5sWazmiqVc1cHYVvld25iRRaF+QqMj9o04fHCd4Rj0B8og3fNzMwfkHk3qOo735MFgvK1krDz+2j+jOruSMBX2JQKHepKf9mTsyDgFdeIpvQolTAjLjd4bpj8VnJSXbx9okZd6DVeqxU9tQOLQilkM4yG+CU=
Message-ID: <9a8748490512131059m54cc56faueaab6ddf0f18520e@mail.gmail.com>
Date: Tue, 13 Dec 2005 19:59:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Cc: Adrian Bunk <bunk@stusta.de>, Simon Richter <Simon.Richter@hogyros.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       Paul Mackerras <paulus@samba.org>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <Pine.LNX.4.62.0512131926530.17990@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211185212.GQ23349@stusta.de>
	 <20051211192109.GA22537@flint.arm.linux.org.uk>
	 <20051211193118.GR23349@stusta.de>
	 <20051211194437.GB22537@flint.arm.linux.org.uk>
	 <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de>
	 <20051213140001.GG23349@stusta.de>
	 <20051213173112.GA24094@flint.arm.linux.org.uk>
	 <20051213180551.GN23349@stusta.de>
	 <Pine.LNX.4.62.0512131926530.17990@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 13 Dec 2005, Adrian Bunk wrote:
> > Do not allow people to create configurations with CONFIG_BROKEN=y.
> >
> > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > fixing a broken driver, but in this case editing the Kconfig file is
> > trivial.
> >
> > Never ever should a user enable CONFIG_BROKEN.
>                       ^^^^
> OK, a user, not an expert. Let's assume users don't enable EXPERIMENTAL.
>
> But I'd like to at least have the possibility to enable broken drivers, even if
> it's just for compile regression tests.
>
I agree, and it's very convenient to be able to enable it in
menuconfig etc. Perhaps CONFIG_BROKEN should just be moved to kernel
hacking instead...?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
