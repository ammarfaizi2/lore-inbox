Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVDHAMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVDHAMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDHAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:10:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:57837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262630AbVDHAKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:10:38 -0400
Date: Thu, 7 Apr 2005 16:36:29 -0700
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] ds1337 1/4
Message-ID: <20050407233628.GA6703@kroah.com>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407231758.GB27226@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 01:17:58AM +0200, Ladislav Michl wrote:
> On Thu, Apr 07, 2005 at 02:18:39PM -0700, Greg KH wrote:
> > Jean's point is that you should send an individual patch for each type
> > of individual change.  It's ok to say "patch 3 requires you to have
> > applied patches 1 and 2" and so on.  Please split this up better.
> 
> Here it is...
> 
> Use i2c_transfer to send message, so we get proper bus locking.

Oops, you forgot to add a Signed-off-by: line for every patch, as per
Documentation/SubmittingPatches.  Care to redo them?

thanks,

greg k-h
