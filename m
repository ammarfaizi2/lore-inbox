Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754140AbWKGJ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbWKGJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbWKGJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:26:13 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:62478 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1754140AbWKGJ0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:26:11 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.19-rc4] usb auerswald possible memleak fix
Date: Tue, 7 Nov 2006 10:25:14 +0100
User-Agent: KMail/1.9.5
Cc: Wolfgang M?es <wolfgang@iksw-muees.de>, linux-kernel@vger.kernel.org
References: <200611061903.09320.m.kozlowski@tuxland.pl> <200611070031.52051.m.kozlowski@tuxland.pl> <20061107002734.GA5236@suse.de>
In-Reply-To: <20061107002734.GA5236@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611071025.15061.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam, 

> On Tue, Nov 07, 2006 at 12:31:51AM +0100, Mariusz Kozlowski wrote:
> > Witam, 
> > 
> > > Hello,
> > > 
> > > 	There is possible memleak in auerbuf_setup(). Fix is to replace kfree() with auerbuf_free().
> > > An argument to usb_free_urb() does not need a check as usb_free_urb() already does that. Not sure if I should
> > > send this in two separate patches. The patch is against 2.6.19-rc4 (not -mm).
> > 
> > As I posted the bigger usb_free_urb() patch in another mail this one
> > should do only one thing which is to fix possible memory leak in
> > auerbuf_setup().
> 
> That is a big patch, care to split it up into smaller pieces like this
> one so that it is easier to review and apply?

Sure I can but Andrew already included it in -mm as-is. Do I have to prepare another set of patches
and send them to you (which is no problem to me - just not sure how it works)?

Regards,

	Mariusz Kozlowski

