Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSIICNM>; Sun, 8 Sep 2002 22:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSIICNM>; Sun, 8 Sep 2002 22:13:12 -0400
Received: from mail.linpro.no ([213.203.57.2]:59917 "HELO linpro.no")
	by vger.kernel.org with SMTP id <S316235AbSIICNL>;
	Sun, 8 Sep 2002 22:13:11 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in pl2303 driver
References: <3D7117D3.5080100@nothing-on.tv> <20020901005124.GA15259@kroah.com> <3D7291BB.1010004@nothing-on.tv> <20020905004514.GB8947@kroah.com>
From: Thorkild Stray <thorkild@linpro.no>
Date: 09 Sep 2002 04:17:53 +0200
In-Reply-To: <20020905004514.GB8947@kroah.com>
Message-ID: <nnfzwjoqi6.fsf@false.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <greg@kroah.com> writes:
>  That makes me very suspicious.  If you can reproduce it with the
>  uhci driver again, please let me know.  I'm getting some odd
>  reports of a problem like this, but I'm unable to reproduce it, and
>  others are having a hard time too.

I recently bought a BAFO BF-810 usb->serial adaptor which also
contained a pl2303 (the driver detects it as one at least). I have
exactly the same behavior as Tony Hoyle. If I use the uhci module,
it'll crash every time (I am using pilot-xfer to backup my palm for
tests). If I change to the usb-uhci driver, it works.

Currently only running 2.4.19pre9. Will try a newer kernel soon. The
driver itself has not changed between 2.4.19pre9 and 2.4.19, though.

(SMP-system). 

-- 
Thorkild Stray, Linpro AS                              <thorkild@linpro.no>
