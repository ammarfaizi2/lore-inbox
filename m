Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTKGWSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbTKGWRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:49 -0500
Received: from thunk.org ([140.239.227.29]:23710 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264619AbTKGUG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 15:06:58 -0500
Date: Fri, 7 Nov 2003 14:58:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, Robert Gyazig <juliarobertz_fan@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
Message-ID: <20031107195856.GB27169@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Pavel Machek <pavel@ucw.cz>,
	Robert Gyazig <juliarobertz_fan@yahoo.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20031106192114.GA23892@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0311071133060.605-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0311071133060.605-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 11:33:42AM +0100, Geert Uytterhoeven wrote:
> > I guess I'll start recomending e2image to people trying software
> > suspend ;-). It really seems like neat tool for "easy backups".
> 
> Note that according to Ted's first post, e2image backs up the _metadata_. He
> didn't mention the real data...

Right.  The idea is that there are a few blocks that if destroyed,
cause the loss of a vast amount of data.  That's why backing up the
metadata is so important....

						- Ted
