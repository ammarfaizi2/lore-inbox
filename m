Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUGTDUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUGTDUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 23:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGTDUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 23:20:46 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:52168
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S264850AbUGTDUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 23:20:45 -0400
Subject: Re: [PATCH] inotify 0.5
From: John McCutchan <ttb@tentacle.dhs.org>
To: Eric Lammerts <eric@lammerts.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Ian Kent <raven@themaw.net>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
In-Reply-To: <Pine.LNX.4.58.0407192242390.28424@vivaldi.madbase.net>
References: <40FBCD8F.1080300@nortelnetworks.com>
	 <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
	 <40FBCD8F.1080300@nortelnetworks.com> <1090272690.6954.1.camel@vertex>
	 <Pine.LNX.4.58.0407192242390.28424@vivaldi.madbase.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1090293890.14653.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Jul 2004 23:24:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 22:59, Eric Lammerts wrote:
> On Mon, 19 Jul 2004, John McCutchan wrote:
> > Also the maximum number of devices that can be opened at a time is
> > 8.
> 
> Why is that limit there? There doesn't seem to be any particular need
> for it in the code... Why not remove watcher_count altogether?
> 

The limits are there to control the amount of kernel resources used by
inotify. They are not meant to be anything but a guesstimate.

John
