Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVDWQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDWQuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDWQuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 12:50:19 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:10727 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261624AbVDWQuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 12:50:16 -0400
Date: Sat, 23 Apr 2005 09:50:15 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
In-Reply-To: <4ae3c14050417085473bd365f@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org>
References: <4ae3c14050417085473bd365f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2005, Xin Zhao wrote:

> Why not simply unset the write bit for all three groups of users? 
> That seems to be enough to prevent file modification.

another usage:  if you "chattr +i /var" while /var is unmounted, then root 
is unlikely to accidentally create files/dirs in /var -- and when you 
mount the real /var on top it works fine.  i tend to protect all my mount 
points this way (especially those in /mnt) to avoid my own dumb mistakes.

-dean
