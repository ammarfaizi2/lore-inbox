Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbTGEGKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbTGEGKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 02:10:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9917 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266281AbTGEGKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 02:10:43 -0400
Date: Sat, 5 Jul 2003 08:23:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: "P. Christeas" <p_christ@hol.gr>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Early mail about synaptics driver
Message-ID: <20030705082358.A13729@ucw.cz>
References: <200306241846.26953.p_christ@hol.gr> <Pine.LNX.4.44.0307050014560.2344-100000@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0307050014560.2344-100000@telia.com>; from petero2@telia.com on Sat, Jul 05, 2003 at 01:09:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 01:09:11AM +0200, Peter Osterlund wrote:
> On Tue, 24 Jun 2003, P. Christeas wrote:
> 
> > I am trying to use your synaptics kernel driver. I do have the touchpad,
> > which means that as from 2.573 the kernel tries to use that by default.
> > 
> > The other important part (which I have solved) is that you set "disable
> > gestures" by default. I don't know if this is required in absolute mode,
> > but it surely makes the touchpad less useful in relative mode. That is,
> > if I unload the module and reload it with 'psmouse_noext=1' [1], then
> > the previous setting [2] applies and gestures are disabled.
> 
> I think it would be better to restore default settings when the driver is
> unloaded, as in the patch below. I have verified that this patch solves
> the problem on my computer using kernel 2.5.74.

Thanks, applied.

 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
