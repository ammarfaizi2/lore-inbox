Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTKYTpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTKYTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:45:54 -0500
Received: from smtp05.web.de ([217.72.192.209]:14867 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262864AbTKYTpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:45:52 -0500
Subject: 2.6.0-preX causes memory corruption
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069789556.2115.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 20:45:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the subject but I have been noticing this problem for quite
some time now under 2 totally different machines and I now belive that
this may be a Kernel issue.

Machine 1 (old):

Elitegroup k7s5a, 256mb, g400, 15gb

After installing 2.6.0-pre9 the System seemed to work normally, all the
stuff I did before worked normally but when doing large fileoperation
including crunching stuff using bzip2 (e.g. checking out modules from
CVS and tar'ing them up) the archives get corrupt. I was first assuming
that this was a onetime mistake and thus I deleted the corrupt file and
re-run my normal operations. But after a while I noticed that this
problem occoured more and more and I was starting to worry. Archives are
showing to be corrupted but after an reset these archives can be
unpacked normally again.

I was really worrying myself if this could be my machine e.g. defective
Ram modules or something thus I ran memtest86 for 3 passes and the
memory was ok. Later on after this problem showed up again I thought
that this may be something else e.g. Motherboard (dying capacitors) my
CPU or whatever.

Anyways I bought totally new hardware (not only because of the problem,
because I wanted to do this anyways and this problem was a good excuse
to go for new stuff 2 days later). So I bought brand new mobo, ram,
harddisk and stuff like that and build the system up:

Machine 2 (new):

Shuttle AK39N, Radeon 9200, 512mb, 40gb Harddisk

Updated my System to 2.6.0-pre10 but the problem still exists. I'm now
really worried what the cause of this problem could be. I know there
could be dozen of reasons such as compiler used, stuff compiled and
things like this but the really strange thing is that I was doing CVS
(and tar'ing up stuff) on a daily basis even with my old machine and
earlier 2.6.0-preX kernels without any problems, the only stuff that I
consistently update is mainly GNOME or KDE, basically NO system updates
happened during 2.6.0-pre5/6 and all in all my system is quite clean.

I know all this is quite vague but now that I totally changed 2
different hardware and that this problem showed up first time with
2.6.0-pre9 (and exists in 10) I may have the tendency to shift this
problem to the Kernel. Also normal operations such as compiling stuff
sometimes end in e.g. telling me that libraries are NOT ELF or that
libraries show wrong stuff etc. and a normal reset usually solved this
which tells me that this is not filesystem related and that the files
itself are in best shape.

Anyways I hope I didn't caused any worries or something but I thought to
let you know about this issue, chances may be that this may indeed be a
kernel issue. May or may not...

greets.

PS: CC me, I'm not subscribed.

