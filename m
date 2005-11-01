Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVKAERm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVKAERm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKAERm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:17:42 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:41657 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932562AbVKAERl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:17:41 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 20:17:39 -0800
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <200510311909.32694.david-b@pacbell.net> <1130815836.29054.420.camel@gaston>
In-Reply-To: <1130815836.29054.420.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510312017.39915.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > "ppc" doens't do anything fancy that other archs don't do too, please
> > > stop with your "ppc specific" thing all over the place.
> > 
> > When the only problem reports come from PPC hardware, it sure looks
> > PPC-specific to me.
> 
> Bla bla bla bla... can you stop the crackpipe please ?

Maybe you should first pay attention to what I pointed out:  that
the problem reports I've seen have ONLY been on PPC systems.

Like the powerbook in $SUBJECT ... people without PPCs are unlikely
to hit such issues, judging by the evidence so far.  (Though of course
it'd be possible...)


> >                   If such issues get reported on non-PPC hardware
> > (with those unique-to-ppc changes to PCI enumeration) then I'll stop
> > thinking of it as PPC-specific.  Until then ... ;)


I guess one point to be made is that although x86 gets the most testing
right away, PPC lately isn't far behind.  Latent bugs in usb-handoff
logic got surfaced by this patch ... there could be others.  I suspect
nobody except x86 users have been running that code much at all.

- Dave

