Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVBRVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVBRVIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVBRVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:08:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261452AbVBRVIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:08:39 -0500
Date: Fri, 18 Feb 2005 16:08:22 -0500
From: Bill Nottingham <notting@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Hotplug blacklist and video devices
Message-ID: <20050218210822.GB8588@nostromo.devel.redhat.com>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	fbdev <linux-fbdev-devel@lists.sourceforge.net>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502181251ea2b95e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl (jonsmirl@gmail.com) said: 
> Why are all of the framebuffer drivers on the hotplug blacklist?

Well, that probably depends on your distribution. :)

Under Fedora (and RHEL), they're there because we generally
don't want to load them unless the user asked for them.

Bill
