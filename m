Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLOQqz>; Fri, 15 Dec 2000 11:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLOQqq>; Fri, 15 Dec 2000 11:46:46 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:12263 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129324AbQLOQqb>; Fri, 15 Dec 2000 11:46:31 -0500
Message-ID: <3A3A43C2.8F045738@inet.com>
Date: Fri, 15 Dec 2000 10:16:02 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dana Lacoste <dana.lacoste@peregrine.com>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <FBF96516CD5@vcnet.vc.cvut.cz> <02c501c066b0$2ae67f00$890216ac@ottawa.loran.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana Lacoste wrote:
> 
> > Maybe you did not notice, but for months we have
> > /lib/modules/`uname -r`/build/include, which points to kernel headers,
> > and which should be used for compiling out-of-tree kernel modules
> > (i.e. latest vmware uses this).
> 
> What about the case where I'm compiling for a kernel that I'm
> not running (yet)?
> 
> lm_sensors, for example, told me yesterday when I compiled it
> that I was running 2.2.17, but it was compiling for 2.2.18
> (because I moved the symlink in /usr/src/linux to point to
> /usr/src/linux-2.2.18)
> 
> I personally wouldn't like some programs to do a `uname -r`
> check because it won't do what I want it to :)

And don't forget cross-compiling...  (No, I don't know how all that is
supposed to work.  *sigh*)

^C-ya,

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
