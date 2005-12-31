Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVLaLbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVLaLbr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLaLbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:31:47 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:39249 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVLaLbq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aJC/xPpFenVEQqVnOpWzfstirXR9LLKH8fNyWWOlVDqw3NM15Z4oSC4nGNnA9ufcjIRo56HPsaH0rl0jyKJ5Ss0Tn4H5U+5T5N2EIZfQ1inwVm9owagcpPBahxCUGEVewVB/1iGhjw4YV6aI/x3uLVlF3ZeKMEuMOQtUdcvleuU=
Message-ID: <9a8748490512310331k6d2cd30fm27533486fe5b5b58@mail.gmail.com>
Date: Sat, 31 Dec 2005 12:31:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B557D7.6090005@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B53EAB.3070800@ns666.com>
	 <9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>
	 <43B557D7.6090005@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Mark v Wolher <trilight@ns666.com> wrote:
>
> Thanks for the advise !
>
> About the memory test, i did that, 7 full passes, no errors, it's 512mb
> ecc memory btw. I'm going to let it, when i go to sleep, run the whole
> night.
>
> hardware:
>
> System is a dell precision workstation 650, dual xeon 2.4ghz w/HT, intel
> E7505 motherboard.
>
> distro: debian sarge
> kernel: vanilla 2.6.14.5
>
> for the rest there is nothing special to see in dmesg output, lspci or
> with lsusb. cpuinfo shows everything what it should show.
>
I was not asking if /you/ thought there was any interresting info in
dmesg, I asked for the dmesg outut so that everyone else on the list
reading your email would be able to get some details about your system
from the output.
The same goes for lsci, lsusb, /proc/cpuinfo, ver_linux output, the
kernel .config etc. We don't have your system nor a kernel build
exactely like yours, so we need those details to be able to help you
better, wether or not you think it is relevant to provide that info is
irrelevant, please just provide the info you are asked for if you want
people to try and help you.


> Memoinfo:
>
> MemTotal:       512528 kB
> MemFree:          8760 kB
> Buffers:          2656 kB
> Cached:         236216 kB
> SwapCached:       2052 kB
> Active:         390480 kB
> Inactive:        54756 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       512528 kB
> LowFree:          8760 kB
> SwapTotal:     4883680 kB
> SwapFree:      4864064 kB
> Dirty:             112 kB
> Writeback:           0 kB
> Mapped:         388988 kB
> Slab:            23320 kB
> CommitLimit:   5139944 kB
> Committed_AS:   518952 kB
> PageTables:       1912 kB
> VmallocTotal:   515796 kB
> VmallocUsed:     25496 kB
> VmallocChunk:   487120 kB
>
Thanks.

>
> Other findings;
>
> - all kernels had the same issue, except (not 100 % sure) 2.4.2X kernels
> - tried acpi=noirq without success and many many other acpi options &
> combo's
> - nvidia binary driver replaced by kernel nv driver but without success
>
> I have no reason to suspect the tvcard which is a terratec value with a
> bt878 chip, support in the kernel. But on the other hand it could be the
> tvcard, but i see no relation to anything with it. I tried also using
> DAC snoop in the bios but no good.
>
If you suspect it at all, even slightly, then why not try and remove
it from the equation by simply taking the card out of the machine for
a while?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
