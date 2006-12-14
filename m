Return-Path: <linux-kernel-owner+w=401wt.eu-S932070AbWLNIkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWLNIkU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWLNIkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:40:20 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:41391 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbWLNIkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:40:18 -0500
Date: Thu, 14 Dec 2006 00:40:16 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Jan Beulich <jbeulich@novell.com>
cc: Chris Wright <chrisw@sous-sol.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Michael Buesch <mb@bu3sch.de>,
       Metathronius Galabant <m.galabant@googlemail.com>, stable@kernel.org,
       Michael Krufky <mkrufky@linuxtv.org>,
       Justin Forbes <jmforbes@linuxtx.org>, alan@lxorguk.ukuu.org.uk,
       "Theodore Ts'o" <tytso@mit.edu>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       torvalds@osdl.org, Chuck Wolber <chuckw@quantumlinux.com>,
       Dave Jones <davej@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
In-Reply-To: <45811163.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0612140028410.16018@twinlark.arctic.org>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com> <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com> <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
 <456D56E7.76E4.0078.0@novell.com> <Pine.LNX.4.64.0612131145460.14936@twinlark.arctic.org>
 <20061213203325.GL10475@sequoia.sous-sol.org> <Pine.LNX.4.64.0612131458510.16018@twinlark.arctic.org>
 <45811163.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, Jan Beulich wrote:

> >with the patch it boots perfectly without any command-line args.
> 
> Are you getting the 'Firmware space is locked read-only' message then?

yep...

so let me ask a naive question... don't we want the firmware locked 
read-only because that protects the bios from viruses?  honestly i'm naive 
in this area of pc hardware, but i'm kind of confused why we'd want 
unlocked firmware just so we can detect a RNG.

-dean
