Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVBGKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVBGKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVBGKN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:13:27 -0500
Received: from styx.suse.cz ([82.119.242.94]:15752 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261389AbVBGKNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:13:24 -0500
Date: Mon, 7 Feb 2005 11:14:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050207101417.GB16443@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <20050205104405.GA1401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205104405.GA1401@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 11:44:05AM +0100, Pavel Machek wrote:

> > Here is a patch that exposes the IBM TrackPoint's extended properties
> > as well as scroll wheel emulation.
> > 
> > 
> > I would appreciate comments and suggestions to make this more acceptable.
> > 
> 
> Perhaps this should be done in userspace? It is probably usable on
> non-trackpoint devices, too...
 
For a big part it's not possible to do in userspace, because the
touchpoint doesn't give the pressure information, it only can be mapped
to a button click.

But middle-button-to-scroll would be doable in userspace, yes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
