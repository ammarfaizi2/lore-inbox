Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTDNVbg (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTDNVbg (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:31:36 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:58299 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263958AbTDNVba (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:31:30 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Mon, 14 Apr 2003 23:43:17 +0200
User-Agent: KMail/1.5
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030414190032.GA4459@kroah.com> <200304142311.01245.oliver@neukum.org> <20030414213054.GA5700@kroah.com>
In-Reply-To: <20030414213054.GA5700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142343.17802.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well, for a little elegance you might introduce subdirectories for each
> > type of hotplug event and use only them.
>
> No, that's for the individual scripts/programs to decide.  For example,
> that's what the current hotplug scripts do, but that's not at all what
> the udev program wants to do.

So have them put a symlink into each subdirectory. This is the way it's
done for init since times immemorial.

	Regards
		Oliver

