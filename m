Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTKKTVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTKKTVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:21:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15573 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263647AbTKKTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:21:31 -0500
Date: Sat, 1 Nov 2003 19:08:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
Message-ID: <20031101180822.GS643@openzaurus.ucw.cz>
References: <3FA34523.30902@nodivisions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA34523.30902@nodivisions.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Check your sound driver's sources . Perhaps it allocates GFP_ATOMIC
memory nd drops data on the floor if it is not available.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

