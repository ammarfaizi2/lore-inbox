Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUBOIGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUBOIGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:06:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:25984 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264329AbUBOIGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:06:12 -0500
Date: Sun, 15 Feb 2004 09:06:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Simon Gate <simon@noir.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Message-ID: <20040215080610.GA314@ucw.cz>
References: <20040214224348.67102cfd.simon@noir.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214224348.67102cfd.simon@noir.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 10:43:48PM +0100, Simon Gate wrote:
> Changed from kernel 2.6.1 to 2.6.2 an get this error in dmesg
> 
> psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
> 
> My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?

It's a 2.6.2 bug and fixed in 2.6.3-rc1.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
