Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUHBVK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUHBVK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUHBVK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:10:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1677 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263555AbUHBVK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:10:57 -0400
Date: Mon, 2 Aug 2004 22:09:35 +0100
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
Message-ID: <20040802210935.GF12724@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick <idr@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	DRI developer's list <dri-devel@lists.sourceforge.net>
References: <410E9FEE.60108@us.ibm.com> <20040802204204.88994.qmail@web14926.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802204204.88994.qmail@web14926.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:42:04PM -0700, Jon Smirl wrote:
 > We are really short handed for kernel level DRM developers; most 3D
 > developers work in user space. The main person that wrote it, Gareth
 > Hughes, doesn't seem to work on it any more. Right now there are three
 > to four, non-paid people working part-time on DRM. 
 > 
 > How about you kernel developers working in other areas giving us a hand
 > with reorganizing the DRM code? You don't need to know anything about
 > 3D you would just be reworking the code without changing how it
 > functions.

Whip me, beat me, make me clean up drivers/char/drm

8-)

Seriously, it's not a fun job at all, so finding volunteers may be
somewhat difficult, but for someone with a high pain threshold, it might
be fun[1], but as Ian mentioned, it depends on the payoff.  If subsequent
DRI tree -> kernel merges back out any cleanup work, it's definitly going
to be a waste of time even trying.

Additionally, assuming some grand cleanup happens. Going back the other way
(keeping stuff in the DRI tree up to date with whatever kernel changes were
 made) is going to prove interesting. In short, I'd not expect other OS's to
work out-of-the-box until someone put in the legwork to make them adapt
to whatever changes were made.

Another possibility of course is that the BSD & Linux kernel side bits
go their seperate ways. How active is the kernel side of the BSD world ?

		Dave

[1] Well, fun perhaps for the same sort of person who enjoyed pulling legs
    off of insects as a child, to see if it still wiggles.

