Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHAXX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHAXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHAXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:23:25 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:57816 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750738AbWHAXXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:23:25 -0400
Message-ID: <44CFE256.8080200@linuxtv.org>
Date: Tue, 01 Aug 2006 19:23:02 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Edgar Hucek <hostmaster@ed-soft.at>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 07/45] v4l/dvb: Fix CI on old KNC1 DVBC cards
References: <20060717160652.408007000@blue.kroah.org> <20060717162617.GH4829@kroah.com> <44C61616.7060203@ed-soft.at> <44C6358D.4040502@linuxtv.org> <44C63727.0@ed-soft.at> <20060725171055.GB1846@suse.de>
In-Reply-To: <20060725171055.GB1846@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jul 25, 2006 at 05:22:15PM +0200, Edgar Hucek wrote:
>> I don't own such a dvb card. I only saw it when trying to compile kernel 2.6.17.7.
> 
> Did that patch fix the build issue?

The build issue is indeed fixed with that patch.  Please queue it up for
2.6.17.8


It's already in my git tree for those that want to test it:

http://www.kernel.org/git/?p=linux/kernel/git/mkrufky/v4l-dvb-2.6.17.y.git

Cheers,

Mike Krufky
