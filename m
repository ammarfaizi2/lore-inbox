Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWAJBRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWAJBRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWAJBRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:17:03 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:50562 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750781AbWAJBRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:17:02 -0500
Date: Tue, 10 Jan 2006 01:27:18 +0000
From: John Rigg <ad@sound-man.co.uk>
To: David Lang <dlang@digitalinsight.com>
Cc: John Rigg <ad@sound-man.co.uk>,
       =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
Message-ID: <20060110012718.GA5375@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de> <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz> <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz> <20060110001617.GA5154@localhost.localdomain> <Pine.LNX.4.62.0601091628340.4005@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601091628340.4005@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:29:45PM -0800, David Lang wrote:
> On Tue, 10 Jan 2006, John Rigg wrote:
> 
> >>does the CPU touch the data for these, or do you DMA directly from
> >>userspace (i.e. "zero-copy")?
> >
> >The cards I mentioned use DMA. RME actually advertises that some of their
> >cards can handle 52 channels with zero CPU load. Their onboard DSPs can
> >also do routing and mixing, again without touching the CPU.
> 
> I was under the (apparently mistaken) impression that you couldn't DMA 
> from userspace (something to do with the possibility that the userspace 
> memory pages could be swapped out in the middle of the DMA)

Hmm. Maybe I've been paying too much attention to card vendors'
sales talk :)

John
