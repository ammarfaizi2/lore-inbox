Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVERHmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVERHmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVERHmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:42:15 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:11813 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262121AbVERHmC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4+fEaZ6pahCRzEjDVwZzUkNfu3QQ8glkKjAIRWVLihNejD3h6n1j0NP+YG7NON1pq0w1E44JW1QHVVuH97krcuxRP6Iz9/oJ42vMQypo97UnFC3xJnILyLGSGNmAXixjL8j2pU82721f+UFo5rzdqKk0AQ20vuuE8GUybx0FEc=
Message-ID: <2538186705051800412ec07d5c@mail.gmail.com>
Date: Wed, 18 May 2005 03:41:59 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20050518073756.GA12382@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703394944e949@mail.gmail.com>
	 <20050518072239.GA11889@kroah.com>
	 <253818670505180028696cc991@mail.gmail.com>
	 <20050518073756.GA12382@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/05, Greg KH <greg@kroah.com> wrote:
> On Wed, May 18, 2005 at 03:28:23AM -0400, Yani Ioannou wrote:
> > Hi Greg,
> I don't have a git tree for stuff that is not ready to be sent to Linus
> at that moment.  I'm using quilt to stage stuff and have them be sucked
> into the -mm releases.  It's easier that way for me right now.

Yes I just realized my mistake, OK I'll try the patches against -mm2
along with a patch to update all the added device
callbacks/differences and make sure nothing goes horribly wrong with
it tomorrow. BTW I sent a patch against it87.c to lm_sensors so Jean
could test things (apparently adm1026 hasn't got many users).

Thanks again,
Yani
