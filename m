Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbRBLVeo>; Mon, 12 Feb 2001 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130843AbRBLVee>; Mon, 12 Feb 2001 16:34:34 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:43271 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130823AbRBLVe1>; Mon, 12 Feb 2001 16:34:27 -0500
Message-ID: <3A884F3F.6B8C6F08@namesys.com>
Date: Tue, 13 Feb 2001 00:01:51 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Chris Mason <mason@suse.com>, Daniel Stone <daniel@kabuki.eyep.net>,
        Chris Wedgwood <cw@f00f.org>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <Pine.LNX.4.21.0102121733410.29670-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Mon, 12 Feb 2001, Hans Reiser wrote:
> 
> > Marcelo Tosatti wrote:
> > >
> > > On Sun, 11 Feb 2001, Chris Mason wrote:
> > >
> > > >
> > > >
> > > > On Sunday, February 11, 2001 10:00:11 AM +0300 Hans Reiser
> > > > <reiser@namesys.com> wrote:
> > > >
> > > > > Daniel Stone wrote:
> > > > >>
> > > > >> On 11 Feb 2001 02:02:00 +1300, Chris Wedgwood wrote:
> > > > >> > On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
> > > > >> >
> > > > >> >     I run Reiser on all but /boot, and it seems to enjoy corrupting my
> > > > >> >     mbox'es randomly.
> > > > >> >
> > > > >> > what kind of corruption are you seeing?
> > > > >>
> > > > >> Zeroed bytes.
> > > > >
> > > > > This sounds like the same bug as the syslog bug, please try to help Chris
> > > > > reproduce it.
> > > > >
> > > > > zam, if Chris can't reproduce it by Monday, please give it a try.
> > > > >
> > > >
> > > > I had a bunch of scripts running over the weekend to try and reproduce
> > > > this, but the results were ruined when a major storm killed the power (no,
> > > > still haven't gotten around to configuring my UPS to shut things down ;-).
> > > >
> > > > So, I'll try again.
> > >
> > > Chris,
> > >
> > > Do you know if the people reporting the corruption with reiserfs on
> > > 2.4 were using IDE drives with PIO mode and IDE multicount turned on?
> > >
> > > If so, it may be caused by the problem fixed by Russell King on
> > > 2.4.2-pre2.
> > >
> > > Without his fix, I was able to corrupt ext2 while using PIO+multicount
> > > very very easily.
> >
> > Was the bug you describe also present in the 2.2.* series?  If not, then the
> > bugs are not the same.
> 
> N.

Zam will try to reproduce it tomorrow, he successfully escaped me today and got
to write fun code (a simpler block allocator) instead.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
