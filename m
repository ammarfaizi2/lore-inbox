Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314637AbSEKJ1B>; Sat, 11 May 2002 05:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314645AbSEKJ1A>; Sat, 11 May 2002 05:27:00 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34576 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314637AbSEKJ07>; Sat, 11 May 2002 05:26:59 -0400
Message-Id: <200205110923.g4B9NhY01144@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Chris Friesen <cfriesen@nortelnetworks.com>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: how to redirect serial console to telnet session?
Date: Sat, 11 May 2002 12:26:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDBC5A5.A1844CC0@nortelnetworks.com> <20020510160945.B7165@flint.arm.linux.org.uk> <3CDBD9EA.1826BB48@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 May 2002 12:32, Chris Friesen wrote:
> Russell King wrote:
> > On Fri, May 10, 2002 at 09:05:41AM -0400, Chris Friesen wrote:
> > > Accordingly, I grabbed what looked like the important bits of xconsole,
> > > but it appears that this only gets me stuff written to /dev/console
> > > from userspace. How do I go about getting the output of kernel-level
> > > printk()s as well?
> >
> > Check the LKML archives for something called 'netconsole' (or use
> > google). It got mentioned here about 6 months to a year ago.
>
> I found some patches by Ingo Molnar, but they look like kernel mods.
>
> What I'm really looking for is a way to redirect this from userspace in a
> stock kernel.  I want the serial console as normal, but then for just
> debugging this one thing I want to telnet in over ethernet and basically
> redirect /dev/ttyS0 onto my telnet session.

I did not do it myself (no need yet), but isn't this scriptable?

If you telnet into box which receives serial console data on /dev/ttyS0,
what 'cat /dev/ttyS0' would show in your telnet window?
--
vda
