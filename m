Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWBYKFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBYKFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 05:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWBYKFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 05:05:22 -0500
Received: from mail.suse.de ([195.135.220.2]:17025 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030193AbWBYKFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 05:05:21 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ben Pfaff <blp@cs.stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
References: <200602242149.42735.jesper.juhl@gmail.com>
	<1140821964.3615.95.camel@lade.trondhjem.org>
	<9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
	<20060224231749.GH27946@ftp.linux.org.uk>
	<87oe0wxryk.fsf@benpfaff.org>
	<Pine.LNX.4.61.0602251036080.1479@yvahk01.tjqt.qr>
X-Yow: I wonder if there's anything GOOD on tonight?
Date: Sat, 25 Feb 2006 11:05:18 +0100
In-Reply-To: <Pine.LNX.4.61.0602251036080.1479@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sat, 25 Feb 2006 10:36:43 +0100 (MET)")
Message-ID: <jewtfjeotd.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> Hm, how about "inline"? GCC also just keeps quiet when a function (or 
> prototype) is written as:
>
> inline static int foo(int bar);

"iniline" is not a storage-class specifier, thus it should be handled like
"const" etc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
