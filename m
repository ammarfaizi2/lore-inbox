Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTLFVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTLFVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:53:09 -0500
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:53852 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265256AbTLFVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:53:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Markku Savela <msa@burp.tkv.asdf.org>, zwane@arm.linux.org.uk
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
Date: Sat, 6 Dec 2003 16:52:59 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org> <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com> <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org>
In-Reply-To: <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312061652.59880.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 December 2003 03:56 pm, Markku Savela wrote:
> > From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> >
> > On Sat, 6 Dec 2003, Markku Savela wrote:
> > > I've seen some references to above problem, but no clear answer.
> > > The 'ntpd' is complaining a lot...
> > >
> > > I have ASUS P4S800. Here is some extracts from dmesg (I can provide
> > > more complete dump, if anyone wants something specific.)
> >
> > Does this only happen when running X11?
>
> Hmm.. possibly. When I boot single user, it does not appear to happen.
>

Do you have an ACPI battery stat or thermal monitor apps running (I see
that you have ACPI active). Does it help it you increase the polling 
interval? Too many systems spend too much time in SCI handler...

Dmitry
 
