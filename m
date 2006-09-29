Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWI2A4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWI2A4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWI2A4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:56:15 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:40528 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161242AbWI2A4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:56:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=fNS/XmRBPWNAMu523PaZtYlO3cf6pMaT2rMFTZYKRofYwy6Ned8M906huMSKLJ6rbG8kkmOlEvbR+XRfENVLZoh/ySuTb0TdfP5LCb/lbjss9XD/6wbfLW304QTc0NSxb9jqLx4ZrMjWCUpc6WcpNtktwRXNwPhyBaZtTXRiQUk=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] More USB patches for 2.6.18
Date: Thu, 28 Sep 2006 17:56:06 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <20060928224250.GA23841@kroah.com> <200609281708.34599.david-b@pacbell.net> <20060928172037.69a6a401.akpm@osdl.org>
In-Reply-To: <20060928172037.69a6a401.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281756.07130.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 5:20 pm, Andrew Morton wrote:
> On Thu, 28 Sep 2006 17:08:33 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > ... reviewing and testing those new OHCI changes is still on my
> > list;
> 
> erm, we prefer to do that before code hits mainline.

Exactly why I mentioned the issue.  I trust Alan basically got the
ohci parts of that new root hub suspend code right, but I probably
have a lot more variety in OHCI silicon here ... but virtually no
time to assemble the relevant platform patches and test them with
new patches from MM/etc, given other ongoing work.

On the plus side, I think maybe OMAP1 devel boards are now mostly
buildable straight from kernel GIT (with i2c-omap merged), which is
a BIG improvement for at least one part of the testing equation.

- Dave


> > all that suspend stuff needs care, things that work on PCs don't
> > necessarily work on embedded hardware (where OHCI is common, and
> > PM tends to be more critical).
> 
> I guess we'll find out.
> 
