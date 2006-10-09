Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWJIP4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWJIP4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWJIP4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:56:17 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:2425 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932640AbWJIP4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:56:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=huk0eYSV4caqF9EW0R0sczBdTbKqTgaCE8Skqqx01E4/BpdDzHHDnKJtaU+KEHAnBZSMNO7sBJua4aKRefYPqhlhftr8rIrYm/pXtyU6jELpUo13q4feYgi/TZorwx48xVWK/GEj0myzPCaVjN02Sl85WFtSjqIqBOu0iDi+VIA=  ;
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Mon, 9 Oct 2006 08:56:08 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071703.24599.david-b@pacbell.net> <200610080840.59432.oliver@neukum.org>
In-Reply-To: <200610080840.59432.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610090856.09776.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 October 2006 11:40 pm, Oliver Neukum wrote:
> Am Sonntag, 8. Oktober 2006 02:03 schrieben Sie:
> > On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:
> > 
> > > > > I dare say that the commonest scenario involving USB is a laptop with
> > > > > an input device attached. Input devices are for practical purposes always
> > > > > opened. A simple resume upon open and suspend upon close is useless.
> > 
> > That is, the standard model is useless?  I think you've made
> > a few strange leaps of logic there ... care to fill in those
> > gaps and explain just _why_ that standard model is "useless"???
> 
> If a device is always opened, as mice are, it will not be suspended.

Of course it wiill be suspended, as part of system-wide suspend.
That's the standard model.

> Yet they can be without any data to deliver forever.

