Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUCDD7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCDD7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:59:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261432AbUCDD7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:59:04 -0500
Date: Wed, 3 Mar 2004 22:58:56 -0500
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Michael Weiser <michael@weiser.dinsnail.net>, Ed Tomlinson <edt@aei.ca>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304035856.GA31986@devserv.devel.redhat.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Michael Weiser <michael@weiser.dinsnail.net>,
	Ed Tomlinson <edt@aei.ca>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040303225305.GB30608@weiser.dinsnail.net> <20040304012531.GC2207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304012531.GC2207@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH (greg@kroah.com) said: 
> Sorry, but you're a bit late.  We've been moving this way since before
> 2.4.0.
> 
> The fact that module unload even works today is a blessing due to all of
> the well-documented issues involved.  I doubt any distro will enable
> module unloading because of it.

So, then, answer this question. In previous kernels, 2.4 and otherwise,
a driver or piece of hardware may get into a 'confused' state. You unload
the driver, reload it, it resets, everything is peachy.

How do I reinitialize a driver or hardware in your 'no-unload'
scenario?

Bill
