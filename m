Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbUCMSSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbUCMSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:18:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:47033 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263155AbUCMSSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:18:40 -0500
Date: Sat, 13 Mar 2004 10:15:02 -0800
From: Greg KH <greg@kroah.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
Message-ID: <20040313181502.GC29208@kroah.com>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB36613F@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50BF37ECE4954A4BA18C08D0C2CF88CB36613F@exmail1.se.axis.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 10:10:36AM +0100, Peter Kjellerstedt wrote:
> Looks simple enough.  But I have a small question. 
> In kref_get() and kref_cleanup(), kref is verified 
> not to be NULL before being used.  However, this is 
> not done in kref_put().  An oversight, or as intended?

An oversight, thanks for pointing it out.  I'll go fix it up.

thanks again,

greg k-h
