Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUC3WsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUC3WqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:46:01 -0500
Received: from [63.161.72.3] ([63.161.72.3]:64436 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S261505AbUC3WnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:43:09 -0500
Message-ID: <fe7b2a316047cf1fd19995e24816890f@stdbev.com>
Date: Tue, 30 Mar 2004 16:52:03 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: 2.6.5-rc3-mm1
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
In-Reply-To: <1080684268.3529.72.camel@watt.suse.com>
References: <4069DC40.3070703@blueyonder.co.uk>
            <1080681249.3547.51.camel@watt.suse.com>
            <4069ED67.5050302@blueyonder.co.uk>
            <1080684268.3529.72.camel@watt.suse.com>
X-Mailer: Hastymail 1.0-rc2-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4:04:28 pm 03/30/04 Chris Mason <mason@suse.com> wrote:
> On Tue, 2004-03-30 at 16:57, Sid Boyce wrote:
> >  Chris Mason wrote:
> >
> > > On Tue, 2004-03-30 at 15:44, Sid Boyce wrote:
> > >
> > >
> > >> It builds fine on x86_64 but locks up solid at ----
> > >> found reiserfs format "3.6" with standard journal
> > >> Hard disk light permanently on - 2.6.5-rc2 vanilla is the last
> > >> one to boot fully, haven't tried 2.6.5-rc3 vanilla yet.
> > >>
> > >>
> > >
> > > Have you tried booting with acpi=off?
> > >
> >  With acpi=off, I get a string of messages
>
> Try pci=noacpi

Having a similar problem here with 2.6.5-rc3-mm1, boot stops with:

Unable to load interpreter
No init found

passing pci=noacpi or init=/bin/bash makes not difference. The hard drive
light is off and the system still responds to keyboard events, but cannot
continue. This is on a Toshiba laptop, updating from a working 2.6.4-mm1.
Bios is updated to the latest version. I am also running reisers on the
root partition if that matters.

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


