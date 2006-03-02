Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWCBQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWCBQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWCBQ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:56:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2964 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751623AbWCBQ4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:56:05 -0500
Date: Thu, 2 Mar 2006 08:55:57 -0800
From: Greg KH <greg@kroah.com>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using usblp with ppdev?
Message-ID: <20060302165557.GA31247@kroah.com>
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 04:32:17PM +0100, wixor wrote:
> Hi,
> I have laptop withopt parallel port, and I'm trying to use usb->parallel
> converter to connect to avr isp programmer. I'm trying, but it seems that
> usblp does not register with parport, and ppdev doesn't see the device at
> all. Is it the limitation of ieee1284? Is it possible to use usb->parallel

The linux-usb-devel mailing list is the better place for this...

Anyway, no, the usblp driver is not what you want, you probably want the
uss720 driver, which does register with parport.

hope this helps,

greg k-h
