Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVJDBbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVJDBbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 21:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVJDBbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 21:31:13 -0400
Received: from tantale.fifi.org ([64.81.251.130]:51088 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S1751103AbVJDBbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 21:31:13 -0400
To: Jonathan Andrews <jon@jonshouse.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Missing header an own goal - now im cooked not raw, left sitting alone looking playing with my ttys
References: <1128388984.5118.55.camel@jonspc>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 03 Oct 2005 18:31:10 -0700
In-Reply-To: <1128388984.5118.55.camel@jonspc>
Message-ID: <871x32gja9.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Andrews <jon@jonshouse.co.uk> writes:

> http://krtkg1.rug.ac.be/~colle/C/get_char_without_enter.html
> 
> Forgive my ignorance (on many levels), but please kind people - what is
> the approved way to put a TTY into raw without using curses.
> 
> system("stty raw"); is not possible, as the code has to run embedded and
> that distro lacks stty and some libs it likes.
> 
> I used to use code like the example above, but now structures like
> TIOCGETP seem to be missing from the kernel headers?
> 
> So please kind people - what is the policy - show me the one true way,
> the simplest way .......
> 
> Before anyone complains, it IS a kernel question - the kernel used to
> have headers that worked with the above code - now it don't (unless im
> wrong ..its possible).
> 
> The code is pre existing non curses application running on an embedded
> machine with 2.4.27 kernel, im trying to build it on Fedora core 3
> (2.6.12-1.1378_FC3)

man tcsetattr

Phil.
