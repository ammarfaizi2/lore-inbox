Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbSJQRMb>; Thu, 17 Oct 2002 13:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJQRMb>; Thu, 17 Oct 2002 13:12:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17281 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261763AbSJQRM1>; Thu, 17 Oct 2002 13:12:27 -0400
Date: Thu, 17 Oct 2002 13:20:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christoph Hellwig <hch@infradead.org>
cc: Crispin Cowan <crispin@wirex.com>, Greg KH <greg@kroah.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <20021017175403.A32516@infradead.org>
Message-ID: <Pine.LNX.3.95.1021017130633.6772A-200000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-666635103-1034875223=:6772"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-666635103-1034875223=:6772
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 17 Oct 2002, Christoph Hellwig wrote:

> On Thu, Oct 17, 2002 at 09:51:06AM -0700, Crispin Cowan wrote:
> > My argument against the intent of this change is that no, I do not think 
> > we should restrict LSM modules to be GPL-only. LSM is an API for loading 
> > externally developed packages of software, similar to syscalls. There is 
> > benefit in permitting proprietary modules (you get additional modules 
> > that you would not get otherwise) just as there is benefit in permitting 
> > proprietary applications (you get Oracle, DB2, and WordPerfect).
> 
> My arguement is that I want this flag as a hint for authors of
> propritary security modules that I'm going to sue them if they
> use hook called from code I have copyright on.  This includes such
> central parts as vfs_read/vfs_write.

There is no way of preventing authors from using "your" code once
you publish it. They just can't claim that they wrote it without
violating copyright law. Copyrights and Licensing are two different
independent things. See a Lawyer.

The attached 'C' program, when linked with any proprietary module,
will bypass all the  "EXPORT_GPL_ONLY" and similar "SCREW_YOU" macros.
To prevent using this or other similar work-arounds to road-blocks
thrown in the way of users, you would have to get GNU 'ld' to prevent
partial linking and make sure that all old copies have been destroyed.

This, by example, shows that "GPL Only" is unenforceable.  I suggest
that all the "GPL only" zealots try something new (like more good code),
rather than attempting to prevent honest workers from using code
they helped develop.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

--1678434306-666635103-1034875223=:6772
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="license.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1021017132023.6772B@chaos.analogic.com>
Content-Description: 

LyoNCiAqICAgU2luY2Ugc29tZSBpbiB0aGUgTGludXgta2VybmVsIGRldmVs
b3BtZW50IGdyb3VwIHdhbnQgdG8gcGxheQ0KICogICBsYXd5ZXIsIGFuZCBy
ZXF1aXJlIHRoYXQgYSBHUEwgTGljZW5zZSBleGlzdCBmb3IgZXZlcnkga2Vy
bmVsDQogKiAgIG1vZHVsZSwgIHdlIHByb3ZpZGUgdGhlIGZvbGxvd2luZzoN
CiAqDQogKiAgIEV2ZXJ5dGhpbmcgaW4gdGhpcyBmaWxlIChvbmx5KSBpcyBy
ZWxlYXNlZCB1bmRlciB0aGUgc28tY2FsbGVkDQogKiAgIEdOVSBQdWJsaWMg
TGljZW5zZSwgaW5jb3Jwb3JhdGVkIGhlcmVpbiBieSByZWZlcmVuY2UuDQog
Kg0KICogICBOb3csIHdlIGp1c3QgbGluayB0aGlzIHdpdGggYW55IHByb3By
aWV0YXJ5IGNvZGUgYW5kIGV2ZXJ5Ym9keQ0KICogICBidXQgdGhlIGxhd3ll
cnMgYXJlIGhhcHB5Lg0KICovDQojaWZuZGVmIF9fS0VSTkVMX18NCiNkZWZp
bmUgX19LRVJORUxfXw0KI2VuZGlmDQojaWZuZGVmIE1PRFVMRQ0KI2RlZmlu
ZSBNT0RVTEUNCiNlbmRpZg0KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
I2lmIGRlZmluZWQoTU9EVUxFX0xJQ0VOU0UpDQpNT0RVTEVfTElDRU5TRSgi
R1BMIik7DQojZW5kaWYNCg==
--1678434306-666635103-1034875223=:6772--
