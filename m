Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291281AbSBXVE1>; Sun, 24 Feb 2002 16:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291301AbSBXVET>; Sun, 24 Feb 2002 16:04:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:37892 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291281AbSBXVEJ>; Sun, 24 Feb 2002 16:04:09 -0500
Date: Sun, 24 Feb 2002 22:03:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
Message-ID: <20020224220356.C1706@ucw.cz>
In-Reply-To: <200202241954.g1OJsPA32151@fenrus.demon.nl> <3C7946D9.1020908@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7946D9.1020908@evision-ventures.com>; from dalecki@evision-ventures.com on Sun, Feb 24, 2002 at 09:02:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:02:33PM +0100, Martin Dalecki wrote:
> arjan@fenrus.demon.nl wrote:
> > In article <3C79435E.8030208@evision-ventures.com> you wrote:
> > 
> > 
> >>linux ide driver anyway. And I think that 2.4.x and above don't run on
> >>i386's anymore anyway.
> >>
> > 
> > it was about the i386 architecture, not just 80386 cpus. And yes 2.4 still
> > runs on those; you'be surprised how many
> > embedded systems run 80386 equivalents...
> 
> Interresting. But do they still incorporate ST509 and other
> archaic controllers? Or do they have broken BIOS-es which don't
> setup the geometry information properly? I don't think so.

Actually you cannot connect an IDE drive to a ST509 harddrive
controller. So that isn't handled by the IDE driver anyway and the
change won't affect people using ST509 controllers.

> Well now I'm quite convinced. We can point those people to the legacy
> single host driver anyway...

They have to use it anyway.

> And then the tradeoff goes just in favour of supporting more and more
> common new hardware - it will just make more people happy than it will
> make people loose :-).

-- 
Vojtech Pavlik
SuSE Labs
