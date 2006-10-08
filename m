Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWJHGkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWJHGkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWJHGkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:40:17 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:10119 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750789AbWJHGkQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:40:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] error to be returned while suspended
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071916.27315.oliver@neukum.org> <200610071703.24599.david-b@pacbell.net>
In-Reply-To: <200610071703.24599.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 8 Oct 2006 08:40:59 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200610080840.59432.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 02:03 schrieben Sie:
> On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:
> 
> > > > I dare say that the commonest scenario involving USB is a laptop with
> > > > an input device attached. Input devices are for practical purposes always
> > > > opened. A simple resume upon open and suspend upon close is useless.
> 
> That is, the standard model is useless?  I think you've made
> a few strange leaps of logic there ... care to fill in those
> gaps and explain just _why_ that standard model is "useless"???

If a device is always opened, as mice are, it will not be suspended.
Yet they can be without any data to deliver forever.

	Regards
		Oliver
