Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261444AbSIZSwP>; Thu, 26 Sep 2002 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261445AbSIZSwP>; Thu, 26 Sep 2002 14:52:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25327 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261444AbSIZSwO>;
	Thu, 26 Sep 2002 14:52:14 -0400
Message-ID: <3D935862.2133DEA2@us.ibm.com>
Date: Thu, 26 Sep 2002 11:56:34 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <3D8FC601.80BAC684@us.ibm.com> <20020924051505.GA21499@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> Hi,
> 
> First off, this looks much nicer than what the Driver Hardening Group
> just tried to pass off as event logging.  

Thanks for the feedback.  You've asked a lot of good questions, some of
which have been answered in subsequent posts.  Instead of attempting to 
answer them all now, we'll make sure we take them into account as we 
update and fix the original proposal.  I'll answer a couple though.

> The two groups might want to
> get together to sort out which formats is the desired ones, as they are
> radically different.

We will.

> 
> > * Developers, Distros, Sys Admins, etc. can simply edit the template
> >   (or provide an alternate template) to control which information from
> >   the problem record is displayed, how it is displayed, what language
> >   it is displayed in, and can add additional information like probable
> >   cause, recommended operator actions, recommended repair actions, etc.
> >   ...all without requiring any changes in the device driver source code.
> 
> But who is going to be doing these "translations"?  Kernel log messages
> change with every release.  That would be a _huge_ undertaking to
> translate them all.

I would not expect translations to be done for each and every version. 
Not is the expectation that EVERY prink would be converted, only those that
report errors.

Distros could be motivated to provide translations, etc. for the kernel 
versions that they base new releases on.  It would just have to make
sense for them financially to translate and supplement what's in the
templates AND be an accepted/expected practice in the community (based on
some Distro feedback). 
> 
> I can see someone creating some job security for a long time with this
> task :)
> 

And what's wrong with that ?  8)
