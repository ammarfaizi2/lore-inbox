Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCIQ6T>; Fri, 9 Mar 2001 11:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbRCIQ6K>; Fri, 9 Mar 2001 11:58:10 -0500
Received: from www.topmail.de ([212.255.16.226]:2764 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S130565AbRCIQ57> convert rfc822-to-8bit;
	Fri, 9 Mar 2001 11:57:59 -0500
Message-ID: <019901c0a8b9$fe6c4b20$de00a8c0@homeip.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "Sean Hunter" <sean@dev.sportingbet.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk> <JKEGJJAJPOLNIFPAEDHLEEDGCJAA.laramie.leavitt@btinternet.com> <20010306151242.D31649@dev.sportingbet.com> <20010306163711.A21941@khan.acc.umu.se> <026701c0a681$e93aa2e0$de00a8c0@homeip.net> <20010308130145.O20737@dev.sportingbet.com>
Subject: Re: binfmt_script and ^M
Date: Fri, 9 Mar 2001 16:52:40 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Sean Hunter" <sean@dev.sportingbet.com>
To: "Thorsten Glaser Geuer" <eccesys@topmail.de>
Sent: Thursday, 8. March 2001 13:01
Subject: Re: binfmt_script and ^M


> On Tue, Mar 06, 2001 at 09:10:26PM -0000, Thorsten Glaser Geuer wrote:
> > ----- Original Message ----- 
> > From: "David Weinehall" <tao@acc.umu.se>
> > To: "Sean Hunter" <sean@dev.sportingbet.com>; "Laramie Leavitt" <laramie.leavitt@btinternet.com>; <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, 6. March 2001 15:37
> > Subject: Re: binfmt_script and ^M
> > 
> > 
> > > On Tue, Mar 06, 2001 at 03:12:42PM +0000, Sean Hunter wrote:
> > > > 
> > > > I propose
> > > > /proc/sys/kernel/im_too_lame_to_learn_how_to_use_the_most_basic_of_unix_tools_so_i_want_the_kernel_to_be_filled_with_crap_to_disguise_my_ineptitude
> > > > 
> > > > Any support?
> > > 
> > > <sarcasm>
> > > Hey, let's go even further! Let's add support in all programs for \r\n.
> > 
> > That is no sarcasm, it is ridiculous. CRLF line endings are ISO-IR-6 and
> > US-ASCII standard, and even UN*X systems used them when they had printers
> > (typewriters?) as output device, and no screens. With the Virtual Terminal,
> > Virtual Console stuff times may have changed but we have so many old stuff
> > in it... I won't remove them or didn't think of, but I remember you of:
> >  - lost+found
> >  - using ESC (or Alt???) as META for _shell commands_ which
> >    easily could be Ctrl-Left, Ctrl-Right, Ctrl-Del etc.
> >  - EMACS    :-((
> >  - ED/EX/VI :-(
> > 
> 
> This is pure bullshit, so I'm not copying my response to the list.  None of that
> depends on the kernel.

I did not ever say that it depends on the kernel. The kernel _has to_ depend on
_standards_ coz otherwise it wouldn't be POSIX compliant, it wouldn't obey one
of the most basic ISO standards nowadays, etc. etc.
The kernel is faulty, and it has to use &h0D as CARRIAGE RETURN, whenever this
behaviour seems expactable (stress on -able).

> If he's to lame to do:
> 
> for i in `find . -type f | grep -l "#! .*perl\r"`; do
> perl -pie 's|\r||g' < $i
> done
> 
> ...or...
> 
> ln -snf `which perl`{,\r}
> 
> ...or...
> 
> change his scripts to use "perl -w", which works, and he should use anyway
> 
> ...or...
> 
> Run his scripts directly by doing "perl /the/path/to/broken/script" (which also
> works)
> 
> ...or any of the other solutions that various people suggested

_I_ am not talking about perl coz in my eyes this is waste. But there are numerous
other programmes with problems on it, too.

> ...then why should we accept a kernel patch to fix this non-problem?  This is
> just plain ludicrous.
> 
> 
> Sean
> 
> > 
> > The following does _not_ have to do with any US-ASCII or ISO_646.irv:1991
> > standards which IIRC are inherited by POSIX.
> > > And why not make all program use filenames that have an 8+3 char garbled
> > > equivalent where the last 3 are the indicators of the filetype. Oh, and
> > > let's do everything to make sure the user doesn't leave Gnome/KDE.
> > > And of course, let's add new features to all existing protocols and
> > > other standards to make them "superior" to other implementations.
> > > Oh, and of course, we must require an extra 64 MB of memory and
> > > 500 MB of diskspace for each release, and a 200MHz faster processor.
> > > And let us do all system settings through a registry.
> > > 
> > > OH! Let's change the name of the operating-system to something more
> > > catchy. Hmmm. Let's see. Windows maybe...
> > > </sarcasm>
> > > 
> > > 
> > > /David
> > 
> > I _do_ _not_ like Windoze either, but we live in a world
> > where we have to cope with it. I am even to code windoze
> > apps in order to support linux (no comment on this)...
> > 
-mirabilos


