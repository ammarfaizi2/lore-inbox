Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTIPWpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbTIPWpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:45:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50068 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262538AbTIPWpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:45:53 -0400
Date: Tue, 16 Sep 2003 23:45:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030916224547.GD30188@mail.jlokier.co.uk>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com> <20030916232318.A1699@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916232318.A1699@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> I am especially interested in cases where people can reproduce
> an unwanted key repeat. The question is: is this a bug in our timer code
> or use of timers, or did the keyboard never send the key release code?

I'm seeing bursts of keys when scrolling a lot on the console, but not
long repeats.  Perhaps the long delays in the console are preventing
the timer from triggering on time?

-- Jamie
