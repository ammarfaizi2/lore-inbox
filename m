Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGTC7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGTC7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 22:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUGTC7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 22:59:49 -0400
Received: from [81.173.6.10] ([81.173.6.10]:47577 "HELO vivaldi.madbase.net")
	by vger.kernel.org with SMTP id S265207AbUGTC7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 22:59:48 -0400
Date: Mon, 19 Jul 2004 22:59:27 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Chris Friesen <cfriesen@nortelnetworks.com>, Ian Kent <raven@themaw.net>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
Subject: Re: [PATCH] inotify 0.5
In-Reply-To: <1090272690.6954.1.camel@vertex>
Message-ID: <Pine.LNX.4.58.0407192242390.28424@vivaldi.madbase.net>
References: <40FBCD8F.1080300@nortelnetworks.com>
 <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
 <40FBCD8F.1080300@nortelnetworks.com> <1090272690.6954.1.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jul 2004, John McCutchan wrote:
> Also the maximum number of devices that can be opened at a time is
> 8.

Why is that limit there? There doesn't seem to be any particular need
for it in the code... Why not remove watcher_count altogether?

Eric

