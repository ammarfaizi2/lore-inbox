Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFNVWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFNVWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFNVWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:22:20 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:63672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261345AbVFNVV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:21:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aJIO2GvnL3bKyRC91zCvqLspbEwWpuCQc0io0EtI5xBZDx6hDvDhRuceF+Q6eonXXQRV+/vF12YNj4M8eRngTbMmJ7vuVNdjTPHPF+WAZqX6kqk6JucEe9Ub1wXe53IVF0hqsKSU7SR8U22LPDbvYjLv/4vCIF9k+Ct40Oau4Ac=
Message-ID: <9e4733910506141421382961d2@mail.gmail.com>
Date: Tue, 14 Jun 2005 17:21:54 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: off by one in sysfs
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614210729.GC19875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105061120007061d7b1@mail.gmail.com>
	 <20050614210729.GC19875@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Greg KH <greg@kroah.com> wrote:
> On Sat, Jun 11, 2005 at 11:00:00PM -0400, Jon Smirl wrote:
> > My attribute is a color_map described by 255 lines of 15 chars plus \n.
> 
> Heh, that's pretty big for a single attribute.  Would it be easier to
> just use the binary sysfs file interface for this attribute?

The attribute is formatted in ascii. You can use a script to set it if
you want. It is the gamma correction table for the monitor.

> 
> thanks,
> 
> greg k-h
> 


-- 
Jon Smirl
jonsmirl@gmail.com
