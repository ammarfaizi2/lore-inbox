Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVAHKVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVAHKVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVAHKUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:20:05 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:27656 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262003AbVAHKNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 05:13:18 -0500
Date: Sat, 8 Jan 2005 11:15:28 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jonas Munsin <jmunsin@iki.fi>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH] I2C patches for 2.6.10
Message-Id: <20050108111528.177dc794.khali@linux-fr.org>
In-Reply-To: <20050108062251.GA5006@jupiter.solarsys.private>
References: <11051627762989@kroah.com>
	<11051627762271@kroah.com>
	<20050108062251.GA5006@jupiter.solarsys.private>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> * Greg KH <greg@kroah.com> [2005-01-07 21:39:36 -0800]:
> > ChangeSet 1.1938.445.11, 2004/12/21 11:09:49-08:00, jmunsin@iki.fi
> > 
> > [PATCH] I2C: it87.c update
> > 
> >  - adds manual PWM
> >  - removes buggy "reset" module parameter
> >  - fixes some whitespaces
> > 
> > Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
> > Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> You might hold off on this one patch... see this:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110514540928517&w=3

I second Mark on that. Please do not merge this one until Jonas and I
have analyzed the problem and found an acceptable solution. Stopping
fans on module load isn't exactly a good driver behavior :(

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
