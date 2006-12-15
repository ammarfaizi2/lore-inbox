Return-Path: <linux-kernel-owner+w=401wt.eu-S1030694AbWLPHuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWLPHuG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 02:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030699AbWLPHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 02:50:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4413 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030698AbWLPHuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 02:50:04 -0500
Date: Fri, 15 Dec 2006 16:15:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>,
       Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with SATA and should not be used by any meansis not stable with SATA and should not be used by any means)
Message-ID: <20061215161544.GC4551@ucw.cz>
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <20061212224527.GA4045@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212224527.GA4045@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-12-06 23:45:27, Olivier Galibert wrote:
> On Tue, Dec 12, 2006 at 11:44:18AM -0700, Andrew Robinson wrote:
> > When I said hibernate, I did mention it was to disk, not to ram.
> 
> Suspend to disk is not trustable on Linux, and does not look like it
> will be any time soon.  Suspend to ram has a better chance of becoming

Stop spreading fud. Take powersave + suspend from suse10.2, and see
if you can break it.

sata_nv seems to have problem, that's it. and it triggered problem in
reiserfs. Use ext3 if you care about your data, and yes your drivers
need to support suspend/resume.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
