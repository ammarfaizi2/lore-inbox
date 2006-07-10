Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWGJJ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWGJJ6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGJJ6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:58:34 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:948
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751184AbWGJJ6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:58:34 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Fredrik Roubert <roubert@df.lth.se>
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
Date: Mon, 10 Jul 2006 11:59:41 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org> <20060710094414.GD1640@igloo.df.lth.se>
In-Reply-To: <20060710094414.GD1640@igloo.df.lth.se>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101159.41738.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 11:44, Fredrik Roubert wrote:
> On Sun 09 Jul 23:06 CEST 2006, Alan Stern wrote:
> 
> > Before 2.6.18-rc1, I used to be able to use it as follows:
> >
> > 	Press and hold an Alt key,
> > 	Press and hold the SysRq key,
> > 	Release the Alt key,
> > 	Press and release some hot key like S or T or 7,
> > 	Repeat the previous step as many times as desired,
> > 	Release the SysRq key.
> >
> > This scheme doesn't work any more,
> 
> The SysRq code has been updated to make it useable with keyboards that
> are broken in other ways than your. With the new behaviour, you should
> be able to use Magic SysRq with your keyboard in this way:
> 
> 	Press and hold an Alt key,
> 	Press and release the SysRq key,
> 	Press and release some hot key like S or T or 7,
> 	Repeat the previous step as many times as desired,
> 	Release the Alt key.

While we are at it, does someone know how to trigger
the sysrq on a PowerBook? Kernel Documentation says to press F13,
but the PowerBook keyboard does not have F13.

-- 
Greetings Michael.
