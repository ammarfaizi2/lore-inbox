Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWGYTZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWGYTZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWGYTZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:25:45 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:36843 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964837AbWGYTZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:25:44 -0400
Date: Tue, 25 Jul 2006 15:19:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [stable] Success: tty_io flush_to_ldisc() error message
  triggered
To: Greg KH <greg@kroah.com>
Cc: linux-stable <stable@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607251522_MC3-1-C616-70EA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060725184158.GH9021@kroah.com>

On Tue, 25 Jul 2006 11:41:58 -0700, Greg KH wrote:
> 
> > > Is this simpler change (what I'm running but without the warning
> > > messages) the preferred fix for -stable?
> > 
> > It fixes the problem.
>
> So do you feel this patch should be added to the -stable kernel tree?

I think it's the right fix.

        1.  It fixes a real bug and that's been verified by testing.
        2.  It's the simplest change that does so. (The fix in 2.6.18-rc
            touches a lot of code.)

-- 
Chuck

