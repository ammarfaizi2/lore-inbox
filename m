Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWGHJMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWGHJMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGHJMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:12:01 -0400
Received: from screech.rychter.com ([212.87.11.114]:64957 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP
	id S1750962AbWGHJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:12:00 -0400
From: Jan Rychter <jan@rychter.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson
References: <20060627133321.GB3019@elf.ucw.cz>
	<20060707215656.GA30353@dspnet.fr.eu.org>
	<20060707232523.GC1746@elf.ucw.cz>
	<200607080933.12372.ncunningham@linuxmail.org>
	<20060708002826.GD1700@elf.ucw.cz>
X-Spammers-Please: blackholeme@rychter.com
Date: Sat, 08 Jul 2006 11:11:25 +0200
In-Reply-To: <20060708002826.GD1700@elf.ucw.cz> (Pavel Machek's message of
	"Sat, 8 Jul 2006 02:28:26 +0200")
Message-ID: <m2d5cg1mwy.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
 Pavel> Hi!
 >> > > > So what Pavel wants can be translated as 'please use already
 >> > > > merged code, it can already do what you want without further
 >> > > > changing kernel'.
 >> > >
 >> > > Like we'd want to use unreviewed, extremely new and risky code
 >> > > for something that happily destroy filesystems.
 >> >
 >> > You can either use suspend2 (14000 lines of unreviewed kernel
 >> > code, old) or uswsusp (~500 lines of reviewed kernel code, ~2000
 >> > lines of unreviewed userspace code, new).
 >>
 >> I was going to keep quiet, but I have to say this: If Suspend2 can
 >> rightly be called unreviewed code, it's only because you've been too
 >> busy flaming etc to give it serious review. Personally, though, I
 >> don't think it's right

 Pavel> I really looked at suspend2 hard, year or so ago, when I was
 Pavel> pretty tired of the flamewars. At that point I decided it is way
 Pavel> too big to be acceptable to mainline, and got that crazy idea
 Pavel> about uswsusp, that surprisingly worked out at the end.

I hate these kinds of discussions, but since no one else did, I'm going
to say this very openly: I don't think you should be the one "deciding"
this. I don't know who and why named you the maintainer of all software
suspend solutions that might go into the mainline kernel, but facts are
that after at least two years of your maintainership (or is it more?):

  -- we still don't have working software suspend in the kernel (listen
     to the users),
  -- we have two implementations in the kernel (swsusp and uswsusp),
     none of which people are happy about,
  -- the implementation that many people are very happy with is being
     kept out because of your "decisions",

Again, those are facts. Forget about hand waving, concentrate on the
facts.

Finally, I personally would hold kernel maintainers to higher
standards. Not everyone has the right to say that something is "ugly"
without providing alternate solutions. Read some of Linus' E-mails: if
anyone has the right to wave hands without arguments it is him, but
still if he says something is ugly, he always provides a better
solution, sometimes also implementing it. And it works.

Re-stating the obvious: I'd like to see a maintainer of software suspend
that produces a working software suspend implementation.

I think most kernel developers underestimate how crucially important
suspend is for notebook users. It is the lifeblood of a notebook user's
life. Unless you develop the kernel and reboot your machine regularly,
you want a stable system that you can suspend and resume at any time,
reliably and predictably. This is way more important than new
schedulers or faster filesystems. It's about basic stability.

I know several people who got tired of the constant fight to keep the
machine running and switched to a Mac. I'm about to do the same as well.

As I don't expect any new arguments to appear in this thread
(unfortunately), and as I expect only more hand-waving from your side, I
won't be bothering you all anymore. EOT from my side.

--J.
