Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSLFKan>; Fri, 6 Dec 2002 05:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSLFKan>; Fri, 6 Dec 2002 05:30:43 -0500
Received: from unthought.net ([212.97.129.24]:64645 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262258AbSLFKam>;
	Fri, 6 Dec 2002 05:30:42 -0500
Date: Fri, 6 Dec 2002 11:38:17 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ??? (ACLs)
Message-ID: <20021206103817.GN6155@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org
References: <200212051224.50317.shanehelms@eircom.net> <000901c29c5d$6d194760$2e833841@joe> <aso4kq$2ka$1@penguin.transmeta.com> <3DEFB275.9000807@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DEFB275.9000807@tupshin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 12:09:25PM -0800, Tupshin Harper wrote:
...
> >Yeah, and look how much more secure it is than UNIX.
> >
> >		Linus
> An unfortunately inflamatory argument that avoids the real issue.  I'm 
> not going to argue the security of NT (heaven forbid), but you do 
> completely ignore the benefits of ACLs, including things that 
> capabilities don't provide.
[snip - big argument, ACLs, seen 100 times on lkml before]

DAC (ACLs) add flexibility to security configurations, no argument
there.  Flexibility != security.

DAC without MAC is insane.

Read "The Inevitability of Failure":
   http://www.nsa.gov/selinux/inevit-abs.html

Yes, the current owner/group/other system is DAC too. Adding more
"flexible" (read: disaster-prone) features before MAC (eg. SELinux) is a
standard part of the kernel, is ludicrous.

And no, NT doesn't have MAC. Nor are they likely to get it. Guess why
any local user absolutely 0wnZ an NT box...

If you want to argue with me on these statements, please take it off
list.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
