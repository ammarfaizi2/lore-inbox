Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286252AbRLTOBA>; Thu, 20 Dec 2001 09:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286254AbRLTOAu>; Thu, 20 Dec 2001 09:00:50 -0500
Received: from unthought.net ([212.97.129.24]:23714 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S286252AbRLTOAi>;
	Thu, 20 Dec 2001 09:00:38 -0500
Date: Thu, 20 Dec 2001 15:00:37 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: svein.ove@aas.no,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011220150037.E16650@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	svein.ove@aas.no,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16GnIg-0000V5-00@starship.berlin> <20011220110936.A18142@atrey.karlin.mff.cuni.cz> <200112201338.OAA23947@mail48.fg.online.no> <20011220145328.C16650@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011220145328.C16650@unthought.net>; from jakob@unthought.net on Thu, Dec 20, 2001 at 02:53:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:53:28PM +0100, Jakob Østergaard wrote:
...
> > Now there's a real world example for you.
> 
> No graphical file manager would use it - how would you show progress
> information to the user when coping a single huge file ?

Sorry for replying to my own mail - I shouldn't send mail while talking
to people at the same time...

The progress stuff is of course relevant only when you cannot do COW.

> 
> So, someone might hack up a 'cp' that used it, and in a few years when
> everyone is at 2.4.x (where x >= version with copyfile()) maybe some
> distribution would ship it.
> 
> Take a look at Win32, then have it. Then, look further, and you'll see
> that they have system calls for just about everything else.  It's
> a slippery slope, leading to horrors like CreateProcess() which takes
> TEN arguments, where about half of them are pointers to STRUCTURES.

s/then have it/they have it/

Sorry,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
