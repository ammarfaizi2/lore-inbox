Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUBBRuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUBBRuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:50:40 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:36804 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265736AbUBBRuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:50:39 -0500
Date: Mon, 2 Feb 2004 09:50:21 -0800
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202175021.GA643@sgi.com>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040201100644.GA2201@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201100644.GA2201@ucw.cz>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
> Problems:
> ~~~~~~~~~
> 
> I'm getting double clicks when I click only once.
> My scroll wheel scrolls by two lines/screens instead of one.
> My mouse moves too fast.
> 
> Solution:
> ~~~~~~~~~
> 
> Check your XFree86 config file. 
> 
> You probably have two "mouse" entries there, one pointing to /dev/psaux and
> the other to /dev/input/mice, so that you can get both your PS/2 and USB
> mouse working on 2.4.
> 
> 2.6 uses the input subsystem for both PS2 and USB, and thus both devices
> will report events from both mice, resulting in doubled events.
> 
> Remove either the /dev/psaux or /dev/input/mice entry, depending what suits
> you better for 2.4 compatibility should you ever need go back to 2.4.

Finally!  Thanks so much for putting together this FAQ Vojtech!  This
mouse thing has been driving me crazy, and despite all my googling
around for a solution, I never found the one above.

Jesse
