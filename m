Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271730AbTG2OUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271741AbTG2OUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:20:52 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:16911 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271730AbTG2OUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:20:30 -0400
Date: Tue, 29 Jul 2003 16:20:25 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: adri <adri@archetti.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030729142025.GA2180@win.tue.nl>
References: <20030728214523.GA485@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728214523.GA485@inwind.it>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 11:45:23PM +0200, adri wrote:

> I have a problem compiling 2.6.0-test1, and later 2.6.0-test2.
> booting the kernel goes well, but when i try to log in my system,
> keyboard seems to be crazy, and when i press a key, it writes the same
> key for almost 4 times, so it is very impossible log in.
> /var/log/syslog don't seems to have something strange.

Could you compile i8042.c with #define DEBUG instead of #undef DEBUG
and report what that yields in the syslog?

