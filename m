Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290340AbSAPDlm>; Tue, 15 Jan 2002 22:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289374AbSAPDlb>; Tue, 15 Jan 2002 22:41:31 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:47804 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289955AbSAPDlT>; Tue, 15 Jan 2002 22:41:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Sean Hunter <sean@dev.sportingbet.com>,
        "Eric S. Raymond" <esr@thyrsus.com>,
        Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou \(ETL\)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Tue, 15 Jan 2002 11:36:29 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114173423.A23081@thyrsus.com> <20020115091414.A3928@dev.sportingbet.com>
In-Reply-To: <20020115091414.A3928@dev.sportingbet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034118.CQZQ26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 04:14 am, Sean Hunter wrote:
> On Mon, Jan 14, 2002 at 05:34:23PM -0500, Eric S. Raymond wrote:
> > Because the second we stop thinking about Aunt Tillie,
> > we start making excuses for badly-designed interfaces and excessive
> > complexity.
>
> Bollocks.  The second we (including you) stop thinking about the _user_ of
> the technology, we make bad decisions.  This is not the same thing.
>
> We don't expect Aunt Tillie to write kernel drivers for her knitting
> machine. She (and we) expect(s) someone else to do that for her.
>
> The Aunt Tillies of this world don't install of update Windows (or Mac O/S)
> for themselves except perhaps via "Windows Update" or "Apple Update", which
> (guess what) supplies a prebuilt binary and DOESN'T BUILD THEM A KERNEL.
>
> Besides any other factor, the download/install/reboot time is less than the
> download-full-tarball/untar/configure/compile/install/reboot cycle.
>
> Sean

Far down on my to-do list is breaking out the "linux from scratch" project, 
reading through it, and making a small, simple distribution that doesn't have 
ANY precompiled binaries except the initial boot disk.  It should compile and 
install everything from source code.  "configure; make; make install"  (I 
wouldn't be suprised if somebody's already done this.  It would save me a lot 
of work, actually.  But I haven't found it yet.)

The reason for this isn't that I expect end-users to deal with it, it's that 
whenever I'm trying to debug a problem in X or Konqueror or some such, it's 
ten times as much work to get the darn thing to compile and install from 
source than it is to track down and patch the actual BUG.  (Especially 
getting the home-built version and the RPM-installed version not to fight to 
the death configuration-wise, either overwriting OR installing them in 
seperate directories.)  Most of the time I just dump the problem on my "to 
do" list and never get around to it.  (I admit X and KDE are a bit worse than 
average here, and I've only really wanted to patch a bug in glibc once.  But 
still, it would be nice to have the option of following my nose into the 
source without doing four hours worth of preparatory work first...)

Possibly I've just had more than my share of bad experiences in this area...

Rob

