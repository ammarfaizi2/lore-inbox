Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJQPHa>; Thu, 17 Oct 2002 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJQPHa>; Thu, 17 Oct 2002 11:07:30 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:50693 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261464AbSJQPH3>; Thu, 17 Oct 2002 11:07:29 -0400
Date: Thu, 17 Oct 2002 16:13:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, crispin@wirex.com
Subject: Re: [PATCH] make LSM register functions GPLonly exports
Message-ID: <20021017161325.A29415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, crispin@wirex.com
References: <20021017153505.A27998@infradead.org> <20021017150740.GA31056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017150740.GA31056@kroah.com>; from greg@kroah.com on Thu, Oct 17, 2002 at 08:07:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 08:07:41AM -0700, Greg KH wrote:
> On Thu, Oct 17, 2002 at 03:35:05PM +0100, Christoph Hellwig wrote:
> > These exports have the power to change the implementations of all
> > syscalls and I've seen people exploiting this "feature".
> > 
> > Make the exports GPLonly (which some LSM folks agreed to
> > when it was merged initially to avoid that).
> 
> I would really, really, really like to make this change.  Unfortunatly,
> one of the current copyright holders of this file does not agree with
> it.
> 
> Crispin, for the benifit of the lkml readers, can you explain why WireX
> does not want this change?

It's GPLed.  It doesn't matter who holds the copyright.

