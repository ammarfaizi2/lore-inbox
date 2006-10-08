Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJHHNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJHHNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWJHHNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:13:44 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:12198 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750859AbWJHHNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:13:43 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 09:14:26 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071916.27315.oliver@neukum.org> <200610071703.24599.david-b@pacbell.net>
In-Reply-To: <200610071703.24599.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610080914.26315.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 02:03 schrieb David Brownell:
> On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:
> 
> > > > I dare say that the commonest scenario involving USB is a laptop with
> > > > an input device attached. Input devices are for practical purposes always
> > > > opened. A simple resume upon open and suspend upon close is useless.
> 
> That is, the standard model is useless?  I think you've made

To be precise a simple implementation of autosuspend is useless.
The idea can be expanded as I wrote if you care to read a bit further.
But still I find the idea to have drawbacks for input devices.

That is not to say that autosuspend is bad in all cases, but there are
unavoidable cases in which it is not optimal, which leads me to conclude
that suspension for a device must remain triggerable from user space.

	Regards
		Oliver
 
