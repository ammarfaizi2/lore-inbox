Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbTIYHrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTIYHrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:47:08 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29384 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261751AbTIYHrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:47:05 -0400
Date: Thu, 25 Sep 2003 09:46:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: PS2 keyboard & mice mandatory again ?
Message-ID: <20030925074656.GA22543@ucw.cz>
References: <1064428364.1673.11.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064428364.1673.11.camel@rousalka.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 08:32:54PM +0200, Nicolas Mailhot wrote:
> Hi,
> 
> 	I've just had the unpleasant surprise to find out that in the latest
> 2.6 snapshots
> 
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> 
> is forced on everyone. I know the modularization of 8042 has generated a
> lot of bug reports, but couldn't people just fix the damn option name
> and description instead of making it mandatory ?
> 
> There are already a lot of people  (me included) with a 100% usb input
> setup. More are on the way (really a nice hub on the desk instead of
> crawling under it to reach PS/2 ports is a no-brainer once you've tested
> it). Please revert this change. 

If you enable CONFIG_EMBEDDED, you can switch it off.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
