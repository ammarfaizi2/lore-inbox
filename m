Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUEVDUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUEVDUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUEVDUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:20:39 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:9589 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265024AbUEVDUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:20:38 -0400
Message-ID: <20040522032038.81570.qmail@web14924.mail.yahoo.com>
Date: Fri, 21 May 2004 20:20:38 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exporting PCI ROMs via syfs
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040521234811.GA13404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:
> And yes, it sounds like we need a quirks file to keep some cards from
> doing bad things.

Another quirk needs to track the boot graphics device. For the boot graphics
device you would export the system RAM at C000:0 instead of exporting it's ROM.
This is because some laptops compress their video ROM or hide the video ROM in
with the system ROM. This problem only impacts the boot video device other
devices don't have this issue.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
