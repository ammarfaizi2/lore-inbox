Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUATP2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUATP2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:28:01 -0500
Received: from smtp-out8.blueyonder.co.uk ([195.188.213.11]:1021 "EHLO
	smtp-out8.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265539AbUATP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:27:59 -0500
Subject: Re: APM and ACPI sleep issues with 2.6
From: Ross Burton <ross@burtonini.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040121015903.0b4198b0.sfr@canb.auug.org.au>
References: <1073232351.21389.111.camel@localhost>
	 <20040105140057.096c77f9.sfr@canb.auug.org.au>
	 <1074520065.32688.9.camel@carados.180sw.com>
	 <20040121015903.0b4198b0.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1074612332.5520.36.camel@carados.180sw.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 15:25:32 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2004 15:28:18.0443 (UTC) FILETIME=[07A72DB0:01C3DF6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 14:59, Stephen Rothwell wrote:
> On Mon, 19 Jan 2004 13:47:45 +0000 Ross Burton <ross@burtonini.com> wrote:
> >
> > On Mon, 2004-01-05 at 03:00, Stephen Rothwell wrote:
> > > > With 2.6.1-rc1-mm, when I shut the lid with APM enabled nothing
> > > > happens.  No messages on the console, nothing.
> > > 
> > > Can you try booting with apm=debug and see if you get any messages
> > > when you shut the lid.
> > 
> > Sorry for the long delay...
> 
> I was actually wondering if there are any messages beginning with "apm:"

Hm, nothing was produced on the console, in dmesg, or in syslog.

> > I've been told that building 2.6.1-mm4, making i8042 and atkdb modules
> > and unloading them before sleeping should fix this problem.  Is that the
> > blessed solution?  Unloading the modules for the keyboard controller
> > does seem a little too much like brute-force for me, especially since
> > 2.4.x managed fine. :)
> 
> I am not sure if you need to build i8042 and atkb as modules amy more, I
> thought there was a fix applied (in 2.6.1?).  However it would be
> interesting to the results of removing the modules before suspending.

Exactly the same messages...

:(

Ross
-- 
Ross Burton                                 mail: ross@burtonini.com
                                          jabber: ross@burtonini.com
                                     www: http://www.burtonini.com./
 PGP Fingerprint: 1A21 F5B0 D8D0 CFE3 81D4 E25A 2D09 E447 D0B4 33DF

