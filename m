Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWIXOaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWIXOaB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIXOaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:30:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39862 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750936AbWIXOaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:30:00 -0400
Date: Sun, 24 Sep 2006 16:29:58 +0200
From: Petr Baudis <pasky@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1
Message-ID: <20060924142958.GU13132@pasky.or.cz>
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk> <20060924132213.GE11916@pasky.or.cz> <20060924142005.GF25666@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924142005.GF25666@flint.arm.linux.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Sep 24, 2006 at 04:20:06PM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> I'm now told that the resulting tree after all the commits is correct.
> The problem is that all the files which were supposed to be deleted by
> previous patches ended up actually being deleted by the final patch in
> the series.
> 
> So the resulting tree is fine, it's just that the history is rather
> broken.

Well, that rewritehist batch should work fine even in this case.

(Of course that's assuming that no change was supposed to happen to
those files in the last four days.)

> I think a solution to this might be to use git-apply, but there's one
> draw back - I currently have the facility to unpatch at a later date,
> but git-apply doesn't support -R.

Yes, if there's not too many patches perhaps using git-apply -R would be
simpler. git-apply in git-1.4.2.1 does support -R.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
