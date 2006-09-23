Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWIWI35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWIWI35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWIWI35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:29:57 -0400
Received: from h4x0r5.com ([70.85.31.202]:61710 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751141AbWIWI34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:29:56 -0400
Date: Sat, 23 Sep 2006 01:29:24 -0700
From: Ryan Anderson <ryan@michonline.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Roland Dreier <rdreier@cisco.com>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060923082911.GB1558@h4x0r5.com>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <aday7sbfyuy.fsf@cisco.com> <45144613.2080306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45144613.2080306@garzik.org>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:22:43PM -0400, Jeff Garzik wrote:
> Roland Dreier wrote:
> >My way of handling this has been to wait until you've acted on my
> >first merge request before sending another one.  I also don't touch my
> >published "for-linus" branch in git until you've pulled it.  I just
> >batch up pending changes in my "for-2.6.19" branch until my next merge
> >(and I also encourage people interested in Infiniband to run my
> >for-2.6.19 branch)
> 
> 
> That's pretty much what I do.  I run a
> 	git branch upstream-linus upstream
> 
> and then submit a pull request for the upstream-linus branch.  That way, 
> I can keep working and committing stuff, and don't have to wait for 
> Linus to pull.
> 
> Then, after the pull, I delete the branch
> 	git branch -D upstream-linus
> 
> locally, and repeat the process next time a bunch of changes are queued up.

Just in case anyone else is reading along and absorbing Git commands,
please use:
	git branch -d upstream-linus
which will at least tell you if the commits in that tree aren't in your
current tree before blowing away work in hard-to-recover ways.

(Not necessarily aimed at Jeff.)

-- 

Ryan Anderson
  sometimes Pug Majere
