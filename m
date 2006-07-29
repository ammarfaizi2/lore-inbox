Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWG2KRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWG2KRl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWG2KRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:17:41 -0400
Received: from styx.suse.cz ([82.119.242.94]:54970 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1422732AbWG2KRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:17:40 -0400
Date: Sat, 29 Jul 2006 12:17:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060729101730.GA7438@suse.cz>
References: <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz> <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com> <200607281557.k6SFvn09022794@turing-police.cc.vt.edu> <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com> <200607282314.k6SNESSg019274@turing-police.cc.vt.edu> <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 12:48:51PM +0300, Shem Multinymous wrote:

> I don't think "update frequency" is a good abstraction. The hardware's
> update may not be variable and irrregular (e.g., event-based), and
> there's there's an issue of phase sync to avoid unnecessary latency.
> 
> The lazy polling approach I described in my last post to Vojtech
> ("block until there's  a new readout or N milliseconds have passed,
> whichever is later") looks like a more general, accurate and efficient
> interface.
 
If "N" is given by the kernel, then it's identical to an event-based
approach. ;) Just described in different words.

-- 
Vojtech Pavlik
Director SuSE Labs
