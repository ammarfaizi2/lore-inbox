Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVJ3VXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVJ3VXs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJ3VXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:23:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:57566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932139AbVJ3VXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:23:47 -0500
Date: Sun, 30 Oct 2005 14:23:09 -0800
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@suse.de>
Cc: Daniele Orlandi <daniele@orlandi.com>, linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
Message-ID: <20051030222309.GA9423@kroah.com>
References: <200510301907.11860.daniele@orlandi.com> <17253.14484.653996.225212@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17253.14484.653996.225212@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 08:18:12AM +1100, Neil Brown wrote:
> But then to make matters worse, there is this "sample.sh" file.  UGH!
> It's a bit of shell code exported by the kernel.
>    #!/bin/sh
>    mknod /dev/hda  b 3 0

That's just a "joke" patch that is only in the -mm tree, as it gets
pulled in from my tree.  It's not in mainline, and will never go there.

thanks,

greg k-h
