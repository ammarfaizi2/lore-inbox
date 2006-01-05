Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752222AbWAEVoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbWAEVoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbWAEVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:44:06 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:53157 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1752222AbWAEVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:44:04 -0500
Date: Thu, 5 Jan 2006 22:41:59 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: bug reports ignored?
Message-ID: <20060105214159.GD10923@vanheusden.com>
References: <38150.145.117.21.143.1136477335.squirrel@145.117.21.143>
	<9a8748490601050852t1e10ea6evd8769f2f4719186c@mail.gmail.com>
	<20060105185319.GB10923@vanheusden.com>
	<20060105211715.GC7142@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105211715.GC7142@w.ods.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Jan  6 19:20:40 CET 2006
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
X-Original-Status: RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 20060103210252.GA2043@vanheusden.com
> > Tue, 3 Jan 2006 22:03:36 +0100
> > [2.6.15] reproducable hang
> > this one still happens. System loses total network connectivity. When I
> > dial the system (by phone), asterisk (the software pabx) picks up the
> > phone and plays a sample, then it becomes mute. After that, the system
> > doesn't respond to anything at all. Even sysreq+t is ignored.
> > The last message on the console is:
> > eth1: transmit error tx status register 82
> Then you're in the situation where you have to narrow the bug down to
> something more reproduceable for other people. Possibly very few people
> on the list have 2.6.15 + asterisk + a sample to play + etc...
> Try to strace asterisk when this happens for instance, try to remove

That is not possible. The system doesn't respond to anything at that
time. I was surprised that asterisk still ran. I can easily (10 out of
10 times!) reproduce the problem by running tcpdump.

> a lot of loaded modules and configured options from your system, then
> you will finally reach a case where you can simply reproduce it with
> a 10-line C prog without a complex setup. With those info, it will be
> too complex and boring to try to reproduce your problem on any
> developer's system.

That is not an option unfortunately; production system.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
