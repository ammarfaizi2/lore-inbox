Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132464AbRBENFv>; Mon, 5 Feb 2001 08:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbRBENFl>; Mon, 5 Feb 2001 08:05:41 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:23302 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132675AbRBENFd>; Mon, 5 Feb 2001 08:05:33 -0500
Message-ID: <3A7E9D90.3E694A7A@namesys.com>
Date: Mon, 05 Feb 2001 15:33:20 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Brian Wolfe <ahzz@terrabox.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <E14Pl8Z-0003Hj-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > I was thinking boot time.
> > and if reiserfs is the root partition?  You really want to make them reboot to
> > the old kernel and recompile rather than making them just recompile?
> 
> I want to make sure they get a sane clear message telling them where to
> find the correct compiler and that they didnt read the docs
> 
> > Stop trying to blame something other than the compiler, it is ridiculous.
> 
> WTF does it have to dow with blaming something other than the compiler ?
> 
> Its going to print something like
> 
> Linux 2.4.2-ac3 blah blah
> Error: This kernel was built with a buggy gcc. Please go to
>         http://.... and upgrade

Sorry, thought you were going to make it only reiserfs disabling, ok, if we do
both this and make the compile fail, that is pretty thorough, effective, useful,
etc.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
