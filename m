Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVJJO7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVJJO7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVJJO7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:59:32 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:24372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750848AbVJJO7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:59:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OAzelIwuojDdUwMMLTvM/j1lWtakfQ4kC3B+i804436OWdJ35QLJzYRs0Dxf6fV4D+sMkvz0sPmX8EH92x0Vq/79TguavNIu9u1TNrMk4OLmYpHlQ0conaY3fs/3NGBa7Q2zUndkD5QkcRjdvaCewIVNYgGfxPieCCfIV76sERI=
Message-ID: <9e0cf0bf0510100759v722bbc5ay970b1aa99efba898@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:59:30 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
Reply-To: Alon Bar-Lev <alon.barlev@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Georg Lippold <georg.lippold@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <434A8082.9060202@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com>
	 <20050831215757.GA10804@taniwha.stupidest.org>
	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>
	 <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>
	 <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de>
	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
	 <434A8082.9060202@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Jesper Juhl wrote:
> >
> > Would it make sense to make it 1024 everywhere (and maybe move it out
> > of arch specific files and just set it in one central place) ?
> >
>
> I would agree with that, *BUT* the boot protocol on each architecture
> need to be consistent.
>
> At the very least, though, i386 and x86-64 need to be changed together,
> since they use the same bootstrap.
>

Great!
Will you update the documentation of all?
After that I can try to convince bootloaders fix their code...

Best Regards,
Alon Bar-Lev.
