Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSIATyd>; Sun, 1 Sep 2002 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSIATyd>; Sun, 1 Sep 2002 15:54:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48389 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316860AbSIATyd>; Sun, 1 Sep 2002 15:54:33 -0400
Date: Sun, 1 Sep 2002 20:58:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nicholas Miell <nmiell@attbi.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: OOPS: USB and/or devicefs
Message-ID: <20020901205859.A29797@flint.arm.linux.org.uk>
References: <1030270093.1531.8.camel@entropy> <20020828054647.GA26390@kroah.com> <1030908511.1374.17.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030908511.1374.17.camel@entropy>; from nmiell@attbi.com on Sun, Sep 01, 2002 at 12:28:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 12:28:30PM -0700, Nicholas Miell wrote:
> On Tue, 2002-08-27 at 22:46, Greg KH wrote:
> > Does this still happen on 2.5.32?  I was unable to reproduce it on
> > either 2.5.31, 2.5.31-bk, or 2.5.32.
> > 
> 
> I can reproduce the oops reliably -- but you have to enable slab
> poisoning to do it.

You want to apply zwane's USB patch, and my 2.5.32-usb.diff patch.
Both appeared on lkml today.  It should fix this precise problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

