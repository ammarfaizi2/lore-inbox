Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVBOOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVBOOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVBOOP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:15:56 -0500
Received: from styx.suse.cz ([82.119.242.94]:13708 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261734AbVBOOPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:15:38 -0500
Date: Tue, 15 Feb 2005 15:16:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.6.11-rc4]: IBM TrackPoint configuration support
Message-ID: <20050215141618.GC8119@ucw.cz>
References: <a71293c2050213163253b9b98f@mail.gmail.com> <200502132031.02214.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502132031.02214.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 08:31:01PM -0500, Dmitry Torokhov wrote:
> On Sunday 13 February 2005 19:32, Stephen Evanchik wrote:
> > Here is the latest IBM TrackPoint patch. I believe I made all of the
> > necessary changes in this release including the removal of the
> > middle-to-scroll functionality. One item I didn't address was a
> > comment about checking the return code of ps2_command ..
> > 
> > I looked at other usages and it wasn't clear to me how to actually
> > implement something that is sane. In some places an error causes a
> > return out of the function and in others the return value is ignored.
> > Should I check each return value or the first ?
> 
> I would check all 3 ps2_command calls in trackpoint_init and leave
> the rest as is.
> 
> One more thing - I'd like to see more descriptive names of sysfs
> attributes, for example I'd change "ptson" to "press_to_select",
> "mb" to "middle_btn", etc.
 
Stephen, if you fix the above, and send me the patch, I'll merge it,
there isn't any other problem with it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
