Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVJKEsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVJKEsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVJKEsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:48:21 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:15598 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbVJKEsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yy/LgOtngR7vTeMVcZXrM+wUzS6rNnnQ+MSuyl2Rd/c02ixUQ+ui5d/aIPmAIk9Tagajnl5C4rV+HtzrBwVoEZLxbr0MnMJ160f8OL9KSPiIYbb6DhPKgo0lHKOtPYZ+a4hvYzOdhBu5JJoFlbMcf6kPJnsCsESbcUTS0p1JgO8=
Message-ID: <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>
Date: Mon, 10 Oct 2005 21:48:20 -0700
From: Mark Knecht <markknecht@gmail.com>
To: mkrufky@m1k.net
Subject: Re: PS/2 Keyboard under 2.6.x
Cc: Robert Crocombe <rwcrocombe@raytheon.com>, linux-kernel@vger.kernel.org
In-Reply-To: <434B3C82.5080409@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <434B121A.3000705@raytheon.com>
	 <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
	 <434B3C82.5080409@m1k.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Michael Krufky <mkrufky@m1k.net> wrote:

> >My keyboard is a wireless thing that had a little dongle to make it
> >into ps2. I took that off and used the keyboard as a USB keyboard and
> >it works fine under SMP.
> >
> >This was on 2.6.13-gentoo-r3 for me.
> >
> Have either of you tried the kernel boot option usb=handoff ?  I had
> similar problems, and this fixed it for me.
>
> --
> Michael Krufky

I have not, but in my case simply using the keyboard as a USB keyboard
was enough to make it work. What doesn't work is when I use it through
a dongle as a ps2 keyboard. I'm puzzled as to why usb=handoff would
fix the ps2 keyboard, but I'm willing to try it tomorrow.

Thanks,
Mark
