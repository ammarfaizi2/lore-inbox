Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWGHIO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWGHIO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGHIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:14:55 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:29567 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751266AbWGHIOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:14:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=NXB3Ycm4jWvyVHBAZ7WTqNcp+Rhh2rir+kMBwouMH+LUwXOyBfalnEP7l3z5Ifxfudf12uh9FgmJy+0Qmts7ALfrnmtTBMHIM911SeXT9FJR/y+aySzvdUYs0YR52zYePAlhw+abEnyWoFaTZQPI9HnaAkogeHV4z62bqtFjv5g=  ;
Date: Sat, 8 Jul 2006 10:14:50 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: David R <david@unsolicited.net>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
Message-ID: <20060708081450.GA13201@gollum.tnic>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AD680B.9090603@unsolicited.net> <20060706221747.GA2632@kroah.com> <44AECDF8.4020702@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AECDF8.4020702@unsolicited.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 10:11:20PM +0100, David R wrote:
> Greg KH wrote:
> > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> 
> Done. I may also try to chase down any divergence in the udev/hal scripts the
> weekend. Not a massive deal anyhow, I can always chown the device if I need
> the scanner. It all works just fine.

We had the same problem with openGL applications here at the university. Suse 10
uses a daemon called resmgr that changes the /dev files ownership to the current user
who logs in. check /etc/resmgr.conf.d/*, /etc/resmgr.conf and the docs for
resmgr on how to add yourself to the, I think is the "desktop" group in resmgr
terms, in order to change ownership.

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
