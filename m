Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJUM6S>; Sun, 21 Oct 2001 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276018AbRJUM6I>; Sun, 21 Oct 2001 08:58:08 -0400
Received: from unthought.net ([212.97.129.24]:19843 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S275270AbRJUM5z>;
	Sun, 21 Oct 2001 08:57:55 -0400
Date: Sun, 21 Oct 2001 14:58:29 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Sean Van Buggenum <sv24@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel or std c++ libraries
Message-ID: <20011021145828.A4292@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Sean Van Buggenum <sv24@uow.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200110210150.LAA14611@isis.its.uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <200110210150.LAA14611@isis.its.uow.edu.au>; from sv24@uow.edu.au on Sun, Oct 21, 2001 at 11:50:22AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 11:50:22AM +1000, Sean Van Buggenum wrote:
> Hi ,                                                                  
> I think there's a bug with .. i guess the linux kernel... or standard 
> c++ libraries included with recent installations of mandrake and      
> redhat.                                                               
> I've come to this conclusion because something i've written in c++,   
> very basic stuff... ( using the function seekg() from the fstream     
> library ) works fine on unix installations that i've used, but not on 
> any of the linux installations i've tried on My computer. All the code
>                                                                       
> does is open a binary file with the file pointer set for however many 
> positions from the END of the file (it works when i use the start of  
> the file ) .. and try to read from there.                             
> i've used kernel 2.2.16.... and it didn't work then.. i've recently   
> installed mandrake 8.1 and thought that with the newer kernel         
> included (hoped) it was just a bug in the redhat installation that i  
> had previously. But it still doesn't work.                            
> Is it a bug in the software ? or something to do with my hardware..is 
> what i'd like to know.. i'm using a intel celeron 600 processor.. if  
> that'd be important.                                                  

No the CPU is not important (at this stage anyway).

Tell us:  kernel version, glibc version, compiler version, stdlibc++ version.

And send the code too. (If you can't or won't, or if the code is lenghty, write
up a small program to reproduce the error and send the code for that one
instead).

It's probably a stdlibc++ bug.  If it's a glibc bug or a kernel bug, the same
error can be reproduced in C too - can it ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
