Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292921AbSCDVwt>; Mon, 4 Mar 2002 16:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292922AbSCDVwj>; Mon, 4 Mar 2002 16:52:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45038
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292921AbSCDVwW>; Mon, 4 Mar 2002 16:52:22 -0500
Date: Mon, 4 Mar 2002 13:53:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Vincent Bernat <bernat@free.fr>
Cc: chiranjeevi vaka <cvaka_kernel@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Need Suggestion(modifying kernel source)
Message-ID: <20020304215305.GJ353@matchmail.com>
Mail-Followup-To: Vincent Bernat <bernat@free.fr>,
	chiranjeevi vaka <cvaka_kernel@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020304212315.89890.qmail@web21305.mail.yahoo.com> <m34rjwdn4v.fsf@neo.loria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34rjwdn4v.fsf@neo.loria>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 10:44:00PM +0100, Vincent Bernat wrote:
> OoO En cette soir?e bien amorc?e du lundi 04 mars 2002, vers 22:23,
> chiranjeevi vaka <cvaka_kernel@yahoo.com> disait:
> 
> > The major problem I am getting is, as and when I do a
> > small change, to test that change, I have to compile
> > the whole kernel make boot floppy and reboot the
> > kernel with that floppy and test the code. This way is
> > takinbg too much time. I donno how linux kernel
> > developers will make changes to kernel and test them. 
> 
> http://user-mode-linux.sourceforge.net

Also, you should be able to compile again without "make clean" to only
compile the changed C files and link.  This is possible with kbuild2.4, but
kbuild2.5 should take out the trickyness.

Can someone point out the procedure for kbuild2.4?
