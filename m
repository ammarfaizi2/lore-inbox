Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUJNN4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUJNN4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUJNN4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:56:20 -0400
Received: from soundwarez.org ([217.160.171.123]:36306 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S265093AbUJNN4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:56:18 -0400
Date: Thu, 14 Oct 2004 15:56:21 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 038 release
Message-ID: <20041014135621.GA15451@vrfy.org>
References: <20041014003936.GA8810@kroah.com> <416E2615.6070402@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416E2615.6070402@bio.ifi.lmu.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:09:09AM +0200, Frank Steiner wrote:
> Hi,
> 
> "make install" fails with
> 
> galois tmp/udev-038# make udevdir=/dev DESTDIR=/root/tmp/test/ 
> EXTRAS="extras/scsi_id" install
> make: *** No rule to make target `etc/init.d/udev.debian', needed by 
> `install-initscript'.  Stop.

It's already fixed in the tree. The next version will have it:

  http://linuxusb.bkbits.net:8080/udev/patch@1.921?nav=index.html|ChangeSet@-2d|cset@1.921

Thanks,
Kay
