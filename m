Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVALX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVALX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVALXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:25:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:46477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261579AbVALXYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:24:17 -0500
Date: Wed, 12 Jan 2005 15:16:30 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, mst@mellanox.co.il, tiwai@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112231630.GB15085@kroah.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112151049.7473db7d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 03:10:49PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> > ...
> > And as for that "policy", it's been stated in public by Andrew and
> > Linus and me (if I count for anything, doubtful...) a number of
> > documented times.
> 
> not me ;) It's two lines of code and makes things much simpler for the
> users of our work.  Seems a no-brainer.

Sorry, the "policy" I was referring to was the "out-of-the-tree drivers
are on their own" statement.  Not the use of the HAVE macros.

> And practically speaking, we don't make such fundamental driver-visible
> changes _that_ often - if we end up getting buried under a proliferation of
> HAVE_FOO macros, then the presence of the macros is the least of our
> problems, yes?

Ok, but can someone add a section in the feature-removal-schedule.txt
file about when these specific macros will be removed?  They must be
created with some specific use in mind, right?

thanks,

greg k-h
