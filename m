Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319269AbSHGTXy>; Wed, 7 Aug 2002 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319266AbSHGTXy>; Wed, 7 Aug 2002 15:23:54 -0400
Received: from gherkin.frus.com ([192.158.254.49]:13958 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S319269AbSHGTXx>;
	Wed, 7 Aug 2002 15:23:53 -0400
Message-Id: <m17cWSy-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:117!
In-Reply-To: <20020807143152.GA5991@louise.pinerecords.com> "from Tomas Szepe
 at Aug 7, 2002 04:31:52 pm"
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Aug 2002 14:27:32 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> > Please report this to Nvidia. The linux community does not support or
> > care about bugs reported on any boot when their binary only modules have
> > been loaded
> 
> And in case you're wondering whether lkml people are being assholes about
> binary-only drivers and don't really want to help, note that this particular
> bug has been confirmed many times to indeed be caused by the Nvidia module.

Worse...  When we outcast NVidia users trot over to the linux forum on
the NVidia website, the attitude of the fellow that responds to darned
near every posting might best be summarized as:

	"The 2.5.X series is for kernel developers.  If you fancy
	yourself a kernel developer, you can fix the OS interface
	routines yourself."

It's not clear from the limited amount of time I spend in that forum
whether that poster is an NVidia employee, but if so...  FEH!!!

I supposed it *might* be possible that the source code NVidia *does*
provide can be patched to workaround the braindamage that lurks within
the binary-only module.  Circumstantial evidence suggests the contrary,
or it would have already been done.  Enough has changed within the
2.5.X memory management code that I'm reasonably certain the NVidia
driver problems will require modifications to code we *don't* have
source for.

Consider this an invitation for any NVidia employee "in the know" (who
also reads this list) to comment.  Even a hearty "f*ck off" would beat
the world-class lettin' alone the linux community is currently getting.

Linux zealots who insist I should vote with my dollars are cordially
invited to suggest alternative video cards that (1) are fully
supported under Linux, and (2) perform as well as the NVidia cards do
(when the NVidia driver doesn't crash my system, that is).  I have two
informal benchmarks I care about: the OpenGL "lament" screensaver, and
Unreal Tournament.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
