Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269727AbUJMOkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269727AbUJMOkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269730AbUJMOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:40:21 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:57295 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269727AbUJMOkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:40:16 -0400
From: David Brownell <david-b@pacbell.net>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: Totally broken PCI PM calls
Date: Wed, 13 Oct 2004 06:34:29 -0700
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097455528.25489.9.camel@gaston> <200410121128.33861.david-b@pacbell.net> <416C3E85.3060801@suse.de>
In-Reply-To: <416C3E85.3060801@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410130634.29930.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 1:28 pm, Stefan Seyfried wrote:
> David Brownell wrote:
> 
> > This is with /sys/power/disk set up for "shutdown";
> > the system didn't actually shut down, it restarted
> > the CPU right after snapshotting.
> > 
> > ...
> 
> you have a swap partition?
> swap enabled?

Yes.  "echo suspend > /sys/power/state" works though;
it's only STD that stopped behaving on that system.
Probably OT for this thread though. 
