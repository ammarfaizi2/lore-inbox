Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVADNT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVADNT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVADNT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:19:27 -0500
Received: from holomorphy.com ([207.189.100.168]:37510 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261645AbVADNSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:18:17 -0500
Date: Tue, 4 Jan 2005 05:08:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "L. A. Walsh" <law@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with 2.7)
Message-ID: <20050104130846.GD2708@holomorphy.com>
References: <41D91707.6040102@tlinx.org> <41D9C53A.3030503@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D9C53A.3030503@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 05:20:42PM -0500, Bill Davidsen wrote:
> If the -rc process were in place, new feature freeze until the big green 
> bugs were fixed just before the next release, that actually might be 
> most of a solution.
> No one bug akpm can accurately asses how well fixes come back from 
> vendors, but I suspect that the kernel is moving too fast and vendors 
> "pick one" and stabilize that, by which time the kernel.org is 
> generations down the road. It's possible that some fixes are then 
> rediffed against the current kernel and fed, but I have zero information 
> on that happening or not.

It does happen. I can't give a good estimate of how often. Someone at a
distro may be able to help here, though it's unclear what this specific
point is useful for.

What is a useful observation is that the 2.6-style development model is
not in use in these instances, which instead use the older "frozen"
model. This means that using frozen models in mainline is redundant. The
function and service are available elsewhere and numerous simultaneously
frozen trees guarantees no forward progress during such syzygys.


-- wli
