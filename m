Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWBSWoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBSWoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWBSWoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:44:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31496 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751114AbWBSWoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:44:30 -0500
Date: Sun, 19 Feb 2006 23:44:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060219224417.GA9101@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org> <1140388715.2418.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140388715.2418.42.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 09:38:35AM +1100, Rusty Russell wrote:
> On Sun, 2006-02-19 at 12:36 +0100, Sam Ravnborg wrote:
> > The module parameter warning are still pending - I hope Rusty will
> > comment on yhe suggested patch to use __initdata in the moduleparam
> > macro.
> 
> kernel/params.c's param_sysfs_setup will have to make a copy if you do
> this.  At the moment it keeps the original structure around.
Was afraid something like this was needed. Will take a look what to do.
I will drop you a copy of any potential patch for review.

	Sam
