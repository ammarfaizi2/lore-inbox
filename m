Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRBLXRr>; Mon, 12 Feb 2001 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBLXRd>; Mon, 12 Feb 2001 18:17:33 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:57607 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129075AbRBLXRX>; Mon, 12 Feb 2001 18:17:23 -0500
Message-ID: <3A88675D.47C58360@namesys.com>
Date: Tue, 13 Feb 2001 01:44:45 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <386960000.982019012@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Monday, February 12, 2001 11:42:38 PM +0300 Hans Reiser
> <reiser@namesys.com> wrote:
> 
> >> Chris,
> >>
> >> Do you know if the people reporting the corruption with reiserfs on
> >> 2.4 were using IDE drives with PIO mode and IDE multicount turned on?
> >>
> >> If so, it may be caused by the problem fixed by Russell King on
> >> 2.4.2-pre2.
> >>
> >> Without his fix, I was able to corrupt ext2 while using PIO+multicount
> >> very very easily.
> >
> 
> I suspect the bugfixes in pre2 will fix some of the more exotic corruption
> reports we've seen, but this one (nulls in log files) probably isn't caused
> by a random (or semi-random) lower layer corruption.  These users are not
> seeing random metadata corruption, so I suspect this bug is different (and
> reiserfs specific).
> 
> > Was the bug you describe also present in the 2.2.* series?  If not, then
> > the bugs are not the same.
> >
> 
> In 2.2 code the only data file corruption I know if is caused by a crash....
> 
> -chris

I'd like to announce on our website and mailing list that all  XXX users should
upgrade to 2.4.2pre2.  Do you all agree with this?

What is the exact definition of XXX?

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
