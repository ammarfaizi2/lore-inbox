Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTLWXUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTLWXUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:20:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:44171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262844AbTLWXUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:20:34 -0500
Date: Tue, 23 Dec 2003 15:14:57 -0800
From: Greg KH <greg@kroah.com>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Rob Love'" <rml@ximian.com>,
       "'Jari Soderholm'" <Jari.Soderholm@edu.stadia.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: DEVFS is very good compared to UDEV
Message-ID: <20031223231457.GD16315@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <1072218603.6987.57.camel@fur> <008901c3c9a8$97ac5c50$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008901c3c9a8$97ac5c50$ca41cb3f@amer.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 03:00:43PM -0800, Hua Zhong wrote:
> > So I cannot comment over _why_ defvs is unmaintained, but that is not
> > the point: either way, it stands that devfs is unmaintained.  
> > That is a problem in and of itself.
> 
> It's just my impression that around that time core developers had
> decided to replace devfs with a new model. If I were in ths same shoes,
> I would probably also stop maintaining it. Then 2 years later when
> somebody asks, the reason to replace my code shouldn't be
> "unmaintained". Just the technical reasons should be enough. :-)

Back in June of 2001, Pat Mochel and I talked with Richard about this
whole driver model, sysfs, and udev design at the 2001 kernel summit,
after presenting it to all of the other kernel developers.  He had some
objections, but was very aware of what we wanted to do.

It's not like udev and this whole sysfs / driver model implementation
snuck into the kernel late at night when no one else was looking, and
pounced on all of the poor, unsuspecting devfs users, eating them for a
early morning snack.


greg k-h
