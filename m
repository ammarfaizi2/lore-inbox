Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIBVva>; Sun, 2 Sep 2001 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRIBVvV>; Sun, 2 Sep 2001 17:51:21 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:4358 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S269641AbRIBVvI>;
	Sun, 2 Sep 2001 17:51:08 -0400
Date: Sun, 2 Sep 2001 17:51:19 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <3B9278F3.AFEF3A91@t-online.de>
Message-ID: <Pine.LNX.4.33.0109021748090.2175-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I dont see any conflicts with ac5, and it still doesnt work... I think
Linus's explanation of the problem is more probable... Also, I have not
been able to reproduce the crash with ACPI recently.. It seems that if I
have ACPI, but no APM, it does freeze... Kernel with APM or with no power
management at all will crash under the same circumstances... But how do I
fix that... I dont know...

show version:
ACPI enabled kernel works fine...
Everything else freezes with yenta...

Tester

On Sun, 2 Sep 2001, Gunther Mayer wrote:

> Tester wrote:
> >
> > Hi,
> >
> > ACPI doesnt give a different result.. using 2.4.9-ac5 with pnpbios enabled
> > doesnt change anything either...
>
> On PNPBIOS: recently a hard hang was fixed in -ac by reserving port
> ranges of PNP0c02 (or 0c01?) devices (else yenta would choose these...)
>
> Can you compare "lspnp -v" to see if there is another builtin device
> in conflict with the yenta ioport window allocation ?
>

-- 
Tester
tester@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer

