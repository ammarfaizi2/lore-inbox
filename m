Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWHXNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWHXNLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHXNLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:11:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52459 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751381AbWHXNLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:11:36 -0400
Date: Thu, 24 Aug 2006 15:11:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Serge E. Hallyn" <sergeh@us.ibm.com>
Cc: Mimi Zohar <zohar@us.ibm.com>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060824131127.GB7052@elf.ucw.cz>
References: <20060817230213.GA18786@elf.ucw.cz> <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com> <20060824054933.GA1952@elf.ucw.cz> <20060824130340.GB15680@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824130340.GB15680@sergelap.austin.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I hope this answered some of your questions.  We're working on
> > > more comprehensive documentation, which we'll post with the next
> > > release.
> > 
> > Do you have examples where this security model stops an attack?
> > 
> > Both my mail client and my mozilla will be UNTRUSTED (because of
> > network connections, right?) -- so mozilla exploit will still be able
> > t osee my mail? Not good. And ssh connects to the net, too, so it will
> > not even protect my ~/.ssh/private_key ?
> 
> I believe it will read your private_key while at a higher level, then
> will be demoted when it access the net.
> 
> Is that right?

Hmm.. you are the security expert here :-). But it still needs private
key while accessing the net.. so even if it does read from
~/.ssh/private_key, first,  what stops mozilla from waiting for
ssh to start talking on the network, and then read the key from ssh's
memory?

Do you have examples where this security model stops an attack?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
