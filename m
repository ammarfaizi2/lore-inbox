Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTLCX6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLCX6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:58:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50699 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262730AbTLCX6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:58:48 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Date: 3 Dec 2003 23:47:38 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlsmq$kp2$1@gatekeeper.tmr.com>
References: <20031203115404.GE1810@gnu.org> <Pine.LNX.4.21.0312031316550.28298-100000@mlf.linux.rulez.org> <20031203232726.GC466@gnu.org>
X-Trace: gatekeeper.tmr.com 1070495258 21282 192.168.12.62 (3 Dec 2003 23:47:38 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203232726.GC466@gnu.org>,
Andrew Clausen  <clausen@gnu.org> wrote:
| On Wed, Dec 03, 2003 at 02:07:06PM +0100, Szakacsits Szabolcs wrote:
| > > Can you elaborate?  Autodetect what?  Autodetect if the BIOS supports LBA?
| > 
| > Autodetect to boot from the boot controller's miniport driver or using
| > BIOS. It should have been mentioned in one of the Microsoft articles I
| > referred.
| 
| I'm totally confused.
| 
| What's a miniport driver?  What is a boot controller?  Do these have
| anything to do with LBA?
| 
| Also, you say "autodetect"... you mean it is making a decision to use
| some method (not that I understand this).  How does it make the decision?
| 
| The article doesn't mention "Linear", "LBA", "boot controller" or
| "miniport driver" at all.  (I was looking at
| http://support.microsoft.com/?kbid=98080 - is this the right one?)
| 
| 
| The question I believe I asked was: how does the Windows installation
| software decide whether to use LBA or CHS?  Is this an answer to
| this question?

Some (most?) BIOS implementations let you set this as an option,
something like STANDARD, LARGE and LBA choices. Most today set LBA
unless you force it.

I would expect the Windows installer to use what the BIOS provides, but
I'm happy to say I haven't done a winstall in several years.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
