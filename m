Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBEMKD>; Mon, 5 Feb 2001 07:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRBEMJx>; Mon, 5 Feb 2001 07:09:53 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:22024 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129481AbRBEMJl>; Mon, 5 Feb 2001 07:09:41 -0500
Message-ID: <3A7E904F.797AF09B@namesys.com>
Date: Mon, 05 Feb 2001 14:36:47 +0300
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
 related)
In-Reply-To: <E14PkHY-0003BN-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > In an __init function, have some code that will trigger the bug.
> > This can be used to disable Reiserfs if the compiler was bad.
> > Then the admin gets a printk() and the Reiserfs mount fails.
> 
> Thats actually quite doable. I'll see about dropping the test into -ac that
> way.
NOOOOO!!!!!! It should NOT fail at mount time, it should fail at compile time.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
