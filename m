Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272559AbTHKM7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272542AbTHKM6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:58:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31634 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272559AbTHKM6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:58:35 -0400
Date: Fri, 8 Aug 2003 15:49:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics driver considered harmful
Message-ID: <20030808134947.GD6914@openzaurus.ucw.cz>
References: <20030806195931.GE2712@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806195931.GE2712@vitelus.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why isn't there a config option for this driver? I just tried to
> upgrade to CVS HEAD (bkcvs) from a 2.4 kernel and everything went
> smoothly except my mouse didn't work until I appended
> psmouse_noext=1. This should not be necessary IMHO. It seems that even
> desktop users are forced to compile in this driver, and according at
> least to my experience, it can seriously break things. I don't see
> what the benefits of the synaptics driver are, and it sounds like
> this driver has been causing problems since it was released. The
> driver may well stabilize in the future, but right now it should not
> be a standard part of the PS/2 mouse driver.

Your fix is right, but vojtech seems to be on holidays. You may want to push through
akpm/linus.

Also make it depend on EXPERIMENTAL.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

