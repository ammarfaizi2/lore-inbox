Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVCHXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVCHXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVCHX3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:29:51 -0500
Received: from web52907.mail.yahoo.com ([206.190.39.184]:24493 "HELO
	web52907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262178AbVCHXZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:25:52 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Cmnn3lCEHuNNCApDSbrnnDgJkCD8kU9p31tJS3/1RJvViivYBBYbzkyX2rVn8Mt4FSBwyi0XvdQgTd44R4LKV0AtvXm/qkpUXLgFiZLpF02BGyEnzzkmqETXsARyCCZmC3RNYZt1Gl7Uj5W+ZKlnSp/hLmPZ9YxlqOHT++1BscI=  ;
Message-ID: <20050308232552.97747.qmail@web52907.mail.yahoo.com>
Date: Wed, 9 Mar 2005 00:25:52 +0100 (CET)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: RFD: Kernel release numbering
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050303052100.GA22952@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Dave Jones <davej@redhat.com> a écrit : 
>  > Grump.  Have all these regressions received the appropriate
> level of
>  > visibility on this mailing list?
> 
> For the most part these things are usually known about by
> their upstream
> authors.  To give an example: ALSA update in 2.6.10 broke
> sound for a
> bunch of IBM thinkpads. As it turns out there are quite a lot
> of these
> out there, so when I released a 2.6.10 update for Fedora,
> bugzilla lit
> up like a christmas tree with "Hey, where'd my sound go?"
> reports.
> (It was further confused by a load of other sound card
> problems, but
>  thats another issue).  This got so out of control, Alan asked
> the ALSA
> folks to take a look, and iirc Takashi figured out what had
> caused the
> problem, and it got fixed in the ALSA folks tree, and
> subsequently, in 2.6.11rc.
> 
> Now, during all this time, there hadn't been any reports of
> this problem
> at all on Linux-kernel. Not even from Linus' tree, let alone
> -mm.
> Which amazes me given how widespread the problem was.
> 

I reported once a bug on alsa-devel and cc-ed on lkml 
The sequencer isn't working with my card cs4239 with alsa.


Taking into account that nobody responded on lkml nor
on alsa (the message was awaiting modderator aprouval 
on alsa-devel) i don't think i will send more bug reports 
to alsa. 

Maybe more people are testing the kernel but they don't have 
time to report the bugs (for me it takes about 15 minutes to 
do it properly). And some bugs like "i had a crash last night"
are irrelevant if i don't have some logs traces.

And _you_ (most of you) _want_ _people_ _to_ _test_  
_2.6_ _kernels_ *and in the mean time* _you_ 
_recommend_ _using_ _vendor_ _kernels_. 

So if i want also a stable kernel i should use two trees 
(a vendor tree and a "2.6..whatever" tree) to compile the 
kernel ? How about mm-tree ?
The whole 2.6. tree is strange. On one side you have -mm where
all the "experimental" stuff goes and on the other side there is
Linus's tree (2.6.x) where also some "experimental" stuff goes.
(from a luser/tester point of view)

Also some people need time to test. I have 4 hours free 
every day.




--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

Yahoo! Mail - Votre e-mail personnel et gratuit qui vous suit partout !
 Créez votre Yahoo! Mail sur http://mail.yahoo.fr
