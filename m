Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVAYKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVAYKvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVAYKvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:51:47 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:46604 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261885AbVAYKvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:51:42 -0500
Date: Tue, 25 Jan 2005 11:51:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Message-ID: <20050125105139.GA3494@pclin040.win.tue.nl>
References: <200501250241.14695.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501250241.14695.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:

> Recently there was a patch from Alan regarding access timing violations
> in i8042. It made me curious as we only wait between accesses to status
> register but not data register. I peeked into FreeBSD code and they use
> delays to access both registers and I wonder if that's the piece that
> makes i8042 mysteriously fail on some boards.

You are following this much more closely than I do, but isn't the
usual complaint "2.4 works, 2.6 fails"?
