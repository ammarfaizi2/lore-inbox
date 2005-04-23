Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVDWWxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVDWWxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDWWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:53:19 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:59852 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262154AbVDWWxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:53:15 -0400
Date: Sun, 24 Apr 2005 00:54:22 +0200
From: DervishD <lkml@dervishd.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050423225422.GB512@DervishD>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c14050417085473bd365f@mail.gmail.com> <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org> <4a5cc1ac18788e708f9a5f3a5bd31be0@mac.com> <20050423191213.GA505@DervishD> <ba1e71adc21a7b85ac989786540aee87@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba1e71adc21a7b85ac989786540aee87@mac.com>
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

    Hi Kyle :)

 * Kyle Moffett <mrmacman_g4@mac.com> dixit:
> On Apr 23, 2005, at 15:12, DervishD wrote:
> > * Kyle Moffett <mrmacman_g4@mac.com> dixit:
> >>>another usage:  if you "chattr +i /var" while /var is unmounted,
> >>>then root is unlikely to accidentally create files/dirs in /var --
> >>>and when you mount the real /var on top it works fine.  i tend to
> >>>protect all my mount points this way (especially those in /mnt) to
> >>>avoid my own dumb mistakes.
> >>If you chmod 000 /var beforehand (While it's still unmounted, of
> >>course), then it's also blindingly obvious that it's not mounted in
> >>an ls -l :-D. I too have used this trick on many/most of my
> >>systems.
> >I was doing exactly that, but it has its drawbacks: root still
> >can create files by accident. [...]
> Ah, I meant in combination with the above trick:

    Oh, yes, I was meaning exactly that. I prefer to have '000'
permissions on directories that act as mountpoints just to see at a
glance whether they are mounted or not. You're right, the chattr +i
is just another protection, not a simple visual one ;)
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
