Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUAFKxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAFKxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:53:17 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:473 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261885AbUAFKxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:53:16 -0500
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
From: Matthias Hentges <mailinglisten@hentges.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1073385390.1110.2.camel@kahlua>
References: <1067411342.1574.11.camel@localhost>
	 <20031109131018.GA18342@deneb.enyo.de> <bop47i$7eg$1@gatekeeper.tmr.com>
	 <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
	 <1073385390.1110.2.camel@kahlua>
Content-Type: text/plain
Organization: 
Message-Id: <1073386393.2888.4.camel@mhcln02>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jan 2004 11:53:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Die, 2004-01-06 um 11.36 schrieb Peter Lieverdink:
> On Tue, 2003-11-11 at 10:27, Peter Lieverdink wrote:
> > At 09:41 11/11/2003, you wrote:

[...]

> > My solution has been to not use cryptofs, it crashes with whatever 
> > algorithm I choose :-(
> 
> I've been using 'highmem=off' until now, which provided a workaround.
> Just built 2.6.1-rc1-mm2 and cryptloop+highmem works as it should now.

FYI, cryptoloop works as expected in 2.6.0-mm2 both with and without
highmem support.

A vanilla 2.6.0 ist unusable due to oopses / data corruption (don't fsck
a cryptoloop device!) (again, with and without highmem).

I hope the -mm loop fixes will be included in 2.6.1.

HAND
-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice

