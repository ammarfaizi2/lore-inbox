Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTFJPB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTFJPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:01:26 -0400
Received: from mail.ithnet.com ([217.64.64.8]:6930 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262942AbTFJPBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:01:24 -0400
Date: Tue, 10 Jun 2003 17:14:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: marcelo@conectiva.com.br
Cc: andrew.grover@intel.com, gj@pointblue.com.pl, linux-kernel@vger.kernel.org,
       sunil.saxena@intel.com, len.brown@intel.com, guy.therien@intel.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-Id: <20030610171444.1aff1d3c.skraw@ithnet.com>
In-Reply-To: <1055205899.31139.15.camel@dhcp22.swansea.linux.org.uk>
References: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
	<Pine.LNX.4.55L.0306091901260.27584@freak.distro.conectiva>
	<1055205899.31139.15.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jun 2003 01:44:59 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-06-09 at 23:03, Marcelo Tosatti wrote:
> > Yes, I want to, and will merge it. In 2.4.23-pre.
> > 
> > > I am confident it will merge cleanly.
> > > I am confident it will cause no problems when CONFIG_ACPI=off.
> > > I am confident the total number of working machines will go up.
> > > I am willing to bet $500 of MY OWN MONEY on this.
> > >
> > > Talk to me, man. What would make you happy? A lot is riding on this.
> > 
> > Yes, we're fine. 2.4.23-pre.
> > 
> > 2.4.22 will be a fast enough release to not piss you off on this, trust
> > me.
> 
> Its been in 2.4.21-ac for a while. I have exactly zero reports of it
> causing problems in the acpi=n case, and a whole raft of "the first
> Linux that runs on my toshiba/compaq/hp laptop"
> 
> Works well enough for me to have faith in it now. 

I can back that. In fact I have some SIS-based motherboards that do not run
without the acpi patch.

My personal opinion on the topic "what to put in 2.4.22-pre1?" is:
1) aic (because you can kick Justins' a** if it does not work out, and get rid
of any complaints for what you do yourself to the aic code)
2) acpi (because the code has already gone through some significant testing and
looks promising).

So I guess I would just do the opposite of your current statement. Remember, you
have a chance to win 500 bucks, don't let it go ;-)

Regards,
Stephan

