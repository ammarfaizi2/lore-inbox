Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTGXNuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 09:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGXNuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 09:50:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:13534 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265870AbTGXNuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 09:50:04 -0400
Date: Thu, 24 Jul 2003 10:05:10 -0400
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: frodol@dds.nl, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and mem leak
Message-ID: <20030724140510.GA5551@kroah.com>
References: <1058993883.31093.115.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058993883.31093.115.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:58:03PM -0700, Robert T. Johnson wrote:
> The user kernel bug was discovered by the Berkeley-developed static
> analysis tool, CQual, developed by Jeff Foster, John Kodumal, and many
> others.  The mem leak bug just happened to be in the wrong place at the
> wrong time. :)

Bleah, I thought I fixed these problems :(

I'll take a look at this when I get back from OLS next week, thanks for
pointing it out.

greg k-h
