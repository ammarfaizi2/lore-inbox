Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTDKGZ5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 02:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTDKGZ5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 02:25:57 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:35007 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264292AbTDKGZ4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 02:25:56 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 08:37:37 +0200
User-Agent: KMail/1.5
Cc: Daniel Stekloff <dsteklof@us.ibm.com>
References: <20030411032424.GA3688@kroah.com>
In-Reply-To: <20030411032424.GA3688@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304110837.37545.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway, this works for me, on my machines, and I am very interested in
> feedback from everyone about both this concept, and the implementation
> of this.  I've cced a lot of different lists, as they have all expressed
> interest in this project.

Cool, an utterly new piece of code to play with.
Well, it has some nice issues.

- There's a race with replugging, which you can do little about
- Error handling. What do you do if the invocation ends in EIO ?
- Performance. What happens if you plug in 4000 disks at once?

	Regards
		Oliver

