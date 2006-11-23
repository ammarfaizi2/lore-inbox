Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933986AbWKWVLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933986AbWKWVLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934038AbWKWVLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:11:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:3269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933986AbWKWVLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:11:01 -0500
Date: Thu, 23 Nov 2006 13:10:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: wbrana@gmail.com
Cc: linux-kernel@vger.kernel.org, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] snd-hda-intel: fix insufficient memory
Message-Id: <20061123131048.8490287c.akpm@osdl.org>
In-Reply-To: <a769871e0611231217w1a6a9d1ag7e708eaf5f991981@mail.gmail.com>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
	<20061121224613.548207f9.akpm@osdl.org>
	<a769871e0611220919q62ccdb5k5548062300e35376@mail.gmail.com>
	<20061122120422.7f1f96fe.akpm@osdl.org>
	<a769871e0611231217w1a6a9d1ag7e708eaf5f991981@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 21:17:21 +0100
wbrana@gmail.com wrote:

> On 11/22/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Are the new settings of 64kb and 1MB sufficient?  If not, by how much must
> > they be increased, and why?
> >
> >
> Default size should be increased to 256 kB to allow same buffer length
>  ( 16384 frames )
> with 2 and 8 channels or same buffer time with 48 kHz/16 bit and 96 kHz/32 bit.
> Maximal size should be at least 4096 kB, which should't limit buffer
> time with any sound
> like 192 kHz/8 channels/32 bit.

Please send a new patch, with a *full* changelog which completely describes
the need for the change.

