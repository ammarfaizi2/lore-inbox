Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTDNVAc (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTDNVAb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:00:31 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:55473 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263814AbTDNU7O (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:59:14 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Mon, 14 Apr 2003 23:11:01 +0200
User-Agent: KMail/1.5
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030414190032.GA4459@kroah.com> <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com>
In-Reply-To: <20030414203328.GA5191@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142311.01245.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Now let's be conservative and assume 16KB unswappable memory
> > per task. Now we take the famous 4000 disk case. 64MB. A lot
> > but probably not deadly. But multiply this by 15 and the machine is
> > absolutely dead.
>
> Ok, then the "Enterprise Edition" of the distros that expect to handle
> 4000 disks will have to add the following patch to their version of the
> hotplug package.
>
> In the meantime, the other 99% of current Linux users will exist just
> fine :)

Well, for a little elegance you might introduce subdirectories for each type
of hotplug event and use only them.

	Regards
		Oliver

