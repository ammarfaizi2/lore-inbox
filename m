Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVBDNTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVBDNTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBDNTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:19:49 -0500
Received: from styx.suse.cz ([82.119.242.94]:52458 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261692AbVBDNTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:19:19 -0500
Date: Fri, 4 Feb 2005 14:19:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] Fix "pointer jumps to corner of screen" problem on ALPS Glidepoint touchpads.
Message-ID: <20050204131933.GE10424@ucw.cz>
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com> <m3vf9f8asf.fsf_-_@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vf9f8asf.fsf_-_@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 11:35:12AM +0100, Peter Osterlund wrote:
> Only parse a "z == 127" packet as a relative Dualpoint stick packet if
> the touchpad actually is a Dualpoint device.  The Glidepoint models
> don't have a stick, and can report z == 127 for a very wide finger. If
> such a packet is parsed as a stick packet, the mouse pointer will
> typically jump to one corner of the screen.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
 
Doesn't apply without 2/4, sorry. Please resend it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
