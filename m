Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSBOMdT>; Fri, 15 Feb 2002 07:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSBOMdK>; Fri, 15 Feb 2002 07:33:10 -0500
Received: from unthought.net ([212.97.129.24]:65243 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S288930AbSBOMc6>;
	Fri, 15 Feb 2002 07:32:58 -0500
Date: Fri, 15 Feb 2002 13:32:57 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Michael Sinz <msinz@wgate.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
Message-ID: <20020215133257.G23673@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Michael Sinz <msinz@wgate.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net> <3C6CF4AA.8040808@evision-ventures.com> <20020215131320.E23673@unthought.net> <3C6CFD7A.30503@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C6CFD7A.30503@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 15, 2002 at 01:22:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 01:22:18PM +0100, Martin Dalecki wrote:
> Jakob Østergaard wrote:
..
> 
> >And having process names is nicer than having PIDs - I don't mind if my core
> >files are over-written on subsequent runs, actually it's nice (keeps the disks
> >from filling up).
> >
> They can get long and annoying... They are not suitable for short name 
> filesystems... They provide a good
> hint for deliberate overwrites.... and so on. Basically I think this 
> would be too much of the good.

That is your oppinion, and I disagree.

And that is *exactly* why the suggested patch is so great - we just keep
the "core" name the default, and allow the user to set the name as he
pleases.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
