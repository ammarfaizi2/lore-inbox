Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbRG2KVT>; Sun, 29 Jul 2001 06:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbRG2KU7>; Sun, 29 Jul 2001 06:20:59 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:62472 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267843AbRG2KUt>; Sun, 29 Jul 2001 06:20:49 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: Christoph Hellwig <hch@ns.caldera.de>,
        kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Sun, 29 Jul 2001 22:19:32 +1200
X-Mailer: KMail [version 1.2]
Cc: kernel <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de>
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de>
MIME-Version: 1.0
Message-Id: <01072922193201.03891@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 29 July 2001 04:45, Christoph Hellwig wrote:
> Hi Matthew,
>
> In article <01072901450000.02683@kiwiunixman.nodomain.nowhere> you wrote:
> > Regards to the ReiserFS. Something more spookie, OpenLinux (no boos and
> > hisses please ;) ), they have ReiserFS as a module, yet, when I have the
> > root partition as reiser I have no problems, voo doo magic perhaps?
> > because when I compiled 2.4.7 w/ ReiserFS as a module, the boot forks up.
>
> Well, as reiserfs is a module it needs to be on the initrd.  The install
> of the kernel kernel RPM automatically creates a new initrd which includes
> the modules in /etc/modules/rootfs.  If you don't create a new initrd your
> modular reiserfs setup will of course fail.
>
> > Regarding the last comment, I think Redhat and Caldera have debugging
> > enable (God knows why?), well, Caldera definately dones, after having a
> > look at their default kernel configuration, hence, when I recompiled my
> > kernel to 2.4.7, threw the reiserFS into the guts of the kernel with
> > debugging turned off, there was a speed increase.
>
> Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
> everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
> work).  That is the reason why it is a) marked experimental and is
> completly unsupported (and that is written _big_ _fat_ in manuals and
> similar stuff) and b) has debugging enabled to have the additional sanity
> checks that are under this option and give addtional hints if reiserfs
> fails again.

I've upgraded to 2.4.7 without any problems. 

Regard to the above, that is, moduler ReiserFS, its not really an issue, as 
compiling into the kernel hasn't caused any problems.

Just a little suggestion. Is it possible to offer "kernel binary upgrades" 
every other major release, for example, it shipped with 2.4.2, hence, the 
next upgrade to be release, 2.4.4 then 2.4.6 then 2.4.8. I can compile 
everthing however, I know a couple of people too scared to get down into the 
nitty gritty of Linux and compile their own kernel.

Matthew Gardiner

-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

