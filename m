Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290063AbSAQRGO>; Thu, 17 Jan 2002 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290072AbSAQRGJ>; Thu, 17 Jan 2002 12:06:09 -0500
Received: from ns.suse.de ([213.95.15.193]:27655 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290063AbSAQRFz>;
	Thu, 17 Jan 2002 12:05:55 -0500
Date: Thu, 17 Jan 2002 18:05:53 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <15430.65012.734810.776663@trained-monkey.org>
Message-ID: <Pine.LNX.4.33.0201171804510.23659-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Jes Sorensen wrote:

> Tried it and I can report your patch works as well. I guess I'll need to
> modify my patch to not mangle things if your patch is installed, or at
> least we should keep my patch in place until the latest ACPI gets
> integrated.

Your patch is also useful for the case of CONFIG_ACPI=n
Worth keeping for that alone. I think it needs mangling a little
to look a bit more like the similar HP workaround though,
but thats a minor nit.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

