Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266539AbRGLUdu>; Thu, 12 Jul 2001 16:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbRGLUdl>; Thu, 12 Jul 2001 16:33:41 -0400
Received: from mithra.wirex.com ([208.161.110.91]:42768 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S266539AbRGLUd0>;
	Thu, 12 Jul 2001 16:33:26 -0400
Message-ID: <3B4E0975.FEB8CEA1@wirex.com>
Date: Thu, 12 Jul 2001 13:32:53 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-immunix i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: LA Walsh <law@sgi.com>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Security hooks, "standard linux security" & embedded use
In-Reply-To: <20010712112102.D32683@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> LA Walsh wrote:
> > Dear Linus et al.,
> >         Sorry for the 'form' letter instead of individual names, but I
> > didn't want to have to send this out separately to every kernel developer
> > I know on LKML.
> >
> >         I am asking for your input on the concept of moving the standard
> > Linux security checks into a "Linux Security Module".

For those who haven't heard, this topic is part of ongoing development of the
LSM (Linux Security Module) project.  The intent is to enhance the existing
LKM such that effective security modules can be written.  This was inspired by
comments from Linus during the SELinux presentation at the Linux 2.5 summit.

As Greg K-H said, the home page for LSM is here  http://lsm.immunix.org/   The
intent is to get a minimal set of common "hooks" into the mainline Linux 2.5
kernel such that many of the would-be security-enhancing packages for Linux
are happy.  Much of the effort involved in LSM involves working towards a
consensus of what we all (security) people can live with, such that the Linux
kernel community will accept it.

There was a "Kernel Security Extensions" BOF at USENIX last month, which
largely became a LSM BOF.  For a great summary of the current state of LSM,
check out this very nice write-up at LWN
http://lwn.net/2001/0704/security.php3  It pretty accurately captures the
state of consensus now, and the issues we're working to resolve before
LSM comes and bothers Linus with a patch.

In warming up for coming to bother y'all with a patch, we had a meeting with
Ted Ts'o at USENIX.  Ted indicated to us that, by and large, most of the
consensus represented in the LWN write-up is going in the right direction for
acceptance into the main Linux kernel.  If that is NOT true, we certainly want
to hear about it.

Please cc: linux-security-module@wirex.com on this topic.  The LSM list is
closed to non-subscribers, but I run the mailman moderation of the list, and I
will silently approve any post that is topical.

Thanks,
    Crispin

--
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html

