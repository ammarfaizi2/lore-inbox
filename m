Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbTJKRcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTJKRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:32:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:6616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263334AbTJKRcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:32:23 -0400
Date: Sat, 11 Oct 2003 10:30:24 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad A21 BIOS - EDD information wrong
Message-ID: <20031011173024.GC22274@kroah.com>
References: <20031010235613.GI19046@kroah.com> <Pine.LNX.4.44.0310102143550.5365-100000@iguana.domsch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310102143550.5365-100000@iguana.domsch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:46:05PM -0500, Matt Domsch wrote:
> > > /sys/firmware/edd/int13_dev80/raw_data
> > Hm, I thought you were going to use the sysfs binary file interface for
> > this file, instead of outputing a hex dump.  Any reason for keeping it
> > this way?
> 
> Laziness?  No really, it just slipped my mind.  I've got the read-disk-sig 
> patch I'm working on related to EDD again, so I'll fix it right soon.  
> Would that fit under Linus's 'bug-only' policy?

I would say yes, as it's a bug that the current code is implementing a
hex dump in kernel space :)

thanks,

greg k-h
