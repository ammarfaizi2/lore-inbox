Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbTGCGtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 02:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTGCGtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 02:49:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:19914 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265455AbTGCGtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 02:49:00 -0400
Date: Thu, 3 Jul 2003 09:03:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: laptop w/ external keyboard misprint FYI
Message-ID: <20030703090317.A24322@ucw.cz>
References: <3EFC7716.8050804@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EFC7716.8050804@blue-labs.org>; from david+powerix@blue-labs.org on Fri, Jun 27, 2003 at 12:55:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 12:55:50PM -0400, David Ford wrote:

> Kernel 2.5.73, first time I've used an external keyboard
> 
> When I plug my external Logitech keyboard into my laptop, (shared 
> keyboard/mouse port), dmesg output indicates a generic mouse was 
> attached instead of a keyboard.  The keyboard works, it's just the dmesg 
> info that's inaccurate.
> 
> Keyboard plugged in:
> input: PS/2 Generic Mouse on isa0060/serio1
> 
> Mouse plugged in:
> input: PS/2 Logitech Mouse on isa0060/serio1

Honestly, I don't think this is possible. If your keyboard is detected
as a mouse, it cannot work a a keyboard. Though maybe your
keyboard/mouse controller BIOS may be playing tricks on us.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
