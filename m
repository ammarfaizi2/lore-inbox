Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVDWScl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDWScl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDWScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:32:41 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:56278 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261662AbVDWScj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:32:39 -0400
Date: Sat, 23 Apr 2005 20:33:45 +0200
From: DervishD <lkml@dervishd.net>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050423183345.GH435@DervishD>
Mail-Followup-To: dean gaudet <dean-list-linux-kernel@arctic.org>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c14050417085473bd365f@mail.gmail.com> <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Dean :)

 * dean gaudet <dean-list-linux-kernel@arctic.org> dixit:
> > Why not simply unset the write bit for all three groups of users? 
> > That seems to be enough to prevent file modification.
> another usage:  if you "chattr +i /var" while /var is unmounted, then root 
> is unlikely to accidentally create files/dirs in /var -- and when you 
> mount the real /var on top it works fine.  i tend to protect all my mount 
> points this way (especially those in /mnt) to avoid my own dumb mistakes.

    Hey, man, that's GREAT :)) I'm going to do the same on my system,
thanks for the suggestion.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
