Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUH2RN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUH2RN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUH2RN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:13:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17573 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268214AbUH2RNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:13:44 -0400
Date: Sun, 29 Aug 2004 19:13:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: radeonfb: do not blank during swsusp snapshot
Message-ID: <20040829171342.GA30878@atrey.karlin.mff.cuni.cz>
References: <20040828213535.GA1418@elf.ucw.cz> <1093731051.2170.187.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093731051.2170.187.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > 
> > With display blanked, it is hard to debug anything. And display
> > blanking is not really needed there... Does it look okay?
> 
> Well... I have some patches for that, though not using the
> system_state global (that I don't like, but it seems that you
> decided to go that way anyways)....

It was basically akpm's idea. I don't like it much, but it is better
than existing mess.

> You probably wnat to avoid the call to fb_set_suspend as well

Ok.
-- 
Horseback riding is like software...

