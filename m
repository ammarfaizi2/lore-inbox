Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbTH3UQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 16:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTH3UQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 16:16:03 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:3091 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262077AbTH3UQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 16:16:00 -0400
Date: Sat, 30 Aug 2003 22:15:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Carl Nygard <cjnygard@fast.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: keyboard shift not registered under fast typing or auto-repeat
Message-ID: <20030830221548.A3654@pclin040.win.tue.nl>
References: <1061944729.14320.74.camel@finland> <20030827125056.A1854@pclin040.win.tue.nl> <1062201326.14320.117.camel@finland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062201326.14320.117.camel@finland>; from cjnygard@fast.net on Fri, Aug 29, 2003 at 07:56:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 07:56:22PM -0400, Carl Nygard wrote:

> > > Kernel doesn't register shift state when typing quickly.
> > > Example, 'ls *' shows up as 'ls 8' when typed fast.
> 
> Typing quickly: 
> 
>      ## ^--- Shift-up event
> (and the Shift-down event was never seen)
>
> typing slower,
> 
>     ## ^---- Shift-down event
>     ## ^---- Shift-up event
>
> Is this potentially a hardware problem
> (i.e. should I return my laptop, because this is too d*mn annoying)?

You can try to decide by running a 2.4 kernel on this laptop.
If also 2.4 fails it may be hardware. If not, we must fix 2.6.



