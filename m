Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLVKz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLVKz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLVKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:55:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:19693 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932110AbVLVKz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:55:58 -0500
Subject: Re: [RFC] Let non-root users eject their ipods?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de
In-Reply-To: <1135047119.8407.24.camel@leatherman>
References: <1135047119.8407.24.camel@leatherman>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Dec 2005 10:56:39 +0000
Message-Id: <1135248999.10383.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-19 at 18:51 -0800, john stultz wrote:
> So below is a patch that allows non-root users to eject their ipods. (It
> seems it should be safe_for_write() but eject opens the device for
> RDONLY, so eject may be wrong here as well). 
> 
> Comments, flames?

I think its probably uninteresting to the majority of users to solve it
that way (not that its wrong that I can see). The desktops handle
automount/umount these days and if anything what would cover most bases
is to teach umount a new option/fstab flag so that it will handle the
device eject as it handles the non-root umount management.

