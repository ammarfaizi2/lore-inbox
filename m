Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWF0VAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWF0VAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWF0VAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:00:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3788 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030351AbWF0VAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:00:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/7] Proc file support
Date: Tue, 27 Jun 2006 23:00:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net> <200606262207.38006.rjw@sisk.pl> <200606270850.47419.nigel@suspend2.net>
In-Reply-To: <200606270850.47419.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606272300.25933.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 00:50, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 06:07, Rafael J. Wysocki wrote:
> > On Monday 26 June 2006 18:47, Nigel Cunningham wrote:
> > > Generic routines for implementing the /proc/suspend2 files that allow
> > > the user to configure and tune the subsystem according to their needs.
> >
> > All of the following patches seem to modify the same file:
> > kernel/power/proc.c I'd prefer if these changes were all done in one patch.
> >
> > Rafael
> 
> I've done this with all the new files, so that each part of the file can be 
> considered without suffering from overload.

Well, different parts of the same file tend to depend on each other and it's
sometimes hard to follow the dependencies if they are in different patches.

Rafael
