Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVCDJaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVCDJaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVCDJaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:30:23 -0500
Received: from gate.perex.cz ([82.113.61.162]:26316 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261551AbVCDJ1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:27:03 -0500
Date: Fri, 4 Mar 2005 10:16:38 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, notting@redhat.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050303212115.GJ29371@redhat.com>
Message-ID: <Pine.LNX.4.58.0503041011470.1739@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org>
 <20050303012707.GK10124@redhat.com> <20050303145846.GA5586@pclin040.win.tue.nl>
 <20050303130901.655cb9c4.akpm@osdl.org> <20050303212115.GJ29371@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Dave Jones wrote:

> Other failures have been somewhat more dramatic.
> I know ipsec-tools, and alsa-lib have both caused pain
> on at least one occasion after the last 2-3 kernel updates.

alsa-lib: You mean the problem with the emu10k1 based soundcards from
Creative? It's because the multichannel devices were added and
reorganized. But the basic functionality (sound from front speakers and
analog capturing) should be preserved with all 1.0.x alsa-lib versions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
