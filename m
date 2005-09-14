Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVINPHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVINPHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbVINPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:07:10 -0400
Received: from xenotime.net ([66.160.160.81]:21157 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965235AbVINPHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:07:08 -0400
Date: Wed, 14 Sep 2005 08:07:05 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Search in make menuconfig doesn't work properly
In-Reply-To: <20050914123923.GA16649@kestrel>
Message-ID: <Pine.LNX.4.50.0509140805290.11686-100000@shark.he.net>
References: <20050914065010.GA8430@kestrel.twibright.com>
 <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
 <20050914123923.GA16649@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Karel Kulhavy wrote:

> On Wed, Sep 14, 2005 at 05:27:49AM -0400, Cal Peake wrote:
> > On Wed, 14 Sep 2005, Karel Kulhavy wrote:
> >
> > > I have 2.6.13 and if I press '/' in make menuconfig (Search
> > > Configuration Parameter, Enter Keyword) and enther "emulation", it
> > > doesn't find
> > > CONFIG_BLK_DEV_IDESCSI -  SCSI emulation support.
> >
> > AFAIK it only matches against the CONFIG_ symbols. If you want it to do
> > more cook up a patch ;)
>
> I suggest "Enter Keyword" to be changed to "Enter Keyword to search
> in CONFIG_... symbols".

Makes sense.  or "Enter CONFIG_ symbol to search for: (omit CONFIG_)".

Please send a patch.

-- 
~Randy
