Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVAFPWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVAFPWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVAFPWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:22:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23715 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262859AbVAFPWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:22:24 -0500
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and
	ioctl_compat
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
       VANDROVE@vc.cvut.cz, alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20050106151429.GA19155@infradead.org>
References: <20041215065650.GM27225@wotan.suse.de>
	 <20041217014345.GA11926@mellanox.co.il>
	 <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de>
	 <20050105133448.59345b04.akpm@osdl.org>
	 <20050106140636.GE25629@mellanox.co.il>
	 <20050106145356.GA18725@infradead.org>
	 <20050106150941.GE1830@wotan.suse.de>
	 <20050106151429.GA19155@infradead.org>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 10:22:21 -0500
Message-Id: <1105024942.13396.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 15:14 +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:09:42PM +0100, Andi Kleen wrote:
> > I would agree that it shouldn't be used for in tree code, but for
> > out of tree code it is rather useful. There are other such feature macros
> > for major driver interface changes too (e.g. in the network stack).
> 
> Which is the only place doing it.  We had this discussion in the past
> (lastone I revolve Greg vetoed it).  We simply shouldn't clutter our
> headers for the sake of out of tree drivers - with LINUX_VERSION_CODE
> we've already implemented a mechanism for out of tree drivers.
> 
> p.s. droppe alsa-devel from Cc because of the braindead moderation policy.
> 

Um, alsa-devel is not moderated, we accept posts from non subscribers.
Where do you think all the spam in our archive comes from?

Lee

