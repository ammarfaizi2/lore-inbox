Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132345AbRBEMsu>; Mon, 5 Feb 2001 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRBEMsk>; Mon, 5 Feb 2001 07:48:40 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:56329 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132374AbRBEMsV>; Mon, 5 Feb 2001 07:48:21 -0500
Message-ID: <3A7E998A.9CB7A4B3@namesys.com>
Date: Mon, 05 Feb 2001 15:16:10 +0300
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
In-Reply-To: <E14Pl0J-0003G8-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Thats actually quite doable. I'll see about dropping the test into -ac that
> > > way.
> > NOOOOO!!!!!! It should NOT fail at mount time, it should fail at compile time.
> 
> I was thinking boot time.
and if reiserfs is the root partition?  You really want to make them reboot to
the old kernel and recompile rather than making them just recompile?

Stop trying to blame something other than the compiler, it is ridiculous.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
