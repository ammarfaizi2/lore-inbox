Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbRDPJnn>; Mon, 16 Apr 2001 05:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbRDPJne>; Mon, 16 Apr 2001 05:43:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132898AbRDPJnQ>;
	Mon, 16 Apr 2001 05:43:16 -0400
Date: Mon, 16 Apr 2001 10:43:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Bartz <md-linux-kernel@logi.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010416104310.A29075@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010416020732.30431.qmail@logi.cc>; from md-linux-kernel@logi.cc on Mon, Apr 16, 2001 at 12:07:31PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:
> There is another issue with logging in general:
> 
>                 *COUNTERS MUST NOT BE RESETABLE!!!*

Umm, no.  Counters can be resetable - you just specify that accounting
programs should not reset them, ever.

The ability to reset counters is extremely useful if you're a human
looking at the output of iptables -L -v.  (I thus far know of no one
who can memorise the counter values for around 40 rules).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

