Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286454AbRLTWn4>; Thu, 20 Dec 2001 17:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286452AbRLTWne>; Thu, 20 Dec 2001 17:43:34 -0500
Received: from mail.cafes.net ([207.65.182.25]:1029 "HELO mail.cafes.net")
	by vger.kernel.org with SMTP id <S286441AbRLTWlt>;
	Thu, 20 Dec 2001 17:41:49 -0500
Date: Thu, 20 Dec 2001 16:41:48 -0600
From: Mike Eldridge <diz@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Message-ID: <20011220164148.L23621@mail.cafes.net>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <1008880024.3926.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008880024.3926.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:27:02PM -0600, Reid Hekman wrote:
> Perhaps if we could be so bold as to back Donald Knuth's KKB,MMB,GGB
> proposal (of which I learned here:
> http://www.linuxdoc.org/HOWTO/Large-Disk-HOWTO-3.html ). I understand
> that muddying the waters is not the way to see clearly into the depths
> of computer science for the unwashed masses, but the ambiguity that
> currently exists is very real. I try to explain these issues on what
> seems like a daily basis to many and the duplicitous terms are not
> helpful.

KKB looks a million times better than KiB.  maybe it's the lowercase
letter, i don't know.

> > My personal esthetic distaste for the new terminology (gack!  "kibi" 
> > sounds like something I would feed my cat!) is less important
> > than following best practices.  I'm hoping it will seem less ugly as it
> > becomes more familiar.
> 
> It certainly rated high on my kibbles'n'bits meter as well :-)
> 
> Whatever we do with the abbreviations, I would strongly recommend we
> spell out documention to help educate ( and ease the transition if we
> switch terms) wherever possible. For example:
> 
> 4 binary kilobyte pages
> 1024 decimal kilobyte disk
> 8.4 decimal gigabyte disks
> 4 binary gigabytes of memory
> 10 decimal gigabits of bandwith
> 
> or if that offends the sensibilities:
> 
> 4 kilobytes (binary)
> 1024 kilobytes (decimal)
> 8.4 gigabytes (decimal)
> 
> I know that they are long on keystrokes, but in lieu of an accepted and
> aesthetically pleasing standard, they are clear and unambiguous.

i will agree that the ambiguity sucks and something needs to be done
about it, but i really do find the SI units for binary plain ugly.  i
doubt that anyone would be willing to type as much text for referencing
simple sizes as you explained above.

perhaps simply a base suffix:
	4KB(2) == 4 * 2^10
	4MB(2) == 4 * 2^20
	4KB(10) == 4 * 10^3
	4MB(10) == 4 * 10^4

it's definitely wierd to look at, but it seems to get the point across
easier.  it defines the base, instead of referencing a name (kibi?
please, i don't think enough people will start using these
grossly-sounding prefixes enough to make it the de facto standard).
or perhaps a (d) or (b) qualifier to refer to decimal or binary.

perhaps everybody should just suck it up and go with what's standard?

-mike

--------------------------------------------------------------------------
   /~\  The ASCII                       all that is gold does not glitter
   \ /  Ribbon Campaign                 not all those who wander are lost
    X   Against HTML                          -- jrr tolkien
   / \  Email!

          radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd           
--------------------------------------------------------------------------
