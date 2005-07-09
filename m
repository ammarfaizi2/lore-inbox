Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVGILWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVGILWH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVGILWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:22:07 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:60178 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261204AbVGILWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:22:06 -0400
From: Neil Darlow <neil@darlow.co.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: ns558 mis-detects gameport
Date: Sat, 9 Jul 2005 12:22:01 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz,
       Daniel Drake <dsd@gentoo.org>
References: <200507082136.47475.neil@darlow.co.uk> <20050708212442.GB3584@ucw.cz>
In-Reply-To: <20050708212442.GB3584@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507091222.01860.neil@darlow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

On Friday 08 Jul 2005 22:24, Vojtech Pavlik wrote:
> In the current input GIT tree there is a patch to reverse the order of
> probing (PnP first) for exactly this reason. I expect 2.6.13 should have
> the fix.

Daniel, is it worth backporting this fix for gentoo-sources-2.6.12 so others 
aren't bitten or will we have to wait for 2.6.13?

> As a workaround, you can try disabling the gameport in BIOS. The legacy
> probe won't see it, and the PnP probe might enable it just fine.

Disabling the gameport in my BIOS seems to take it off the bus and PnP doesn't 
see it at all.

Regards,
Neil Darlow
-- 
Anti-virus scanned by ClamAV-0.86.1 - http://www.clamav.net
