Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbTCBNTp>; Sun, 2 Mar 2003 08:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269207AbTCBNTp>; Sun, 2 Mar 2003 08:19:45 -0500
Received: from [66.70.28.20] ([66.70.28.20]:50449 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269206AbTCBNSs>; Sun, 2 Mar 2003 08:18:48 -0500
Date: Sun, 2 Mar 2003 13:53:15 +0100
From: DervishD <raul@pleyades.net>
To: Miles Bader <miles@gnu.org>
Cc: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030302125315.GH45@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Miles :)

 Miles Bader dixit:
> /var is clearly the right place for this; if /var isn't mounted
> initially, I'd suggest that mount should simply not update any file
> at that point, and the init-script that mounts /var can be
> responsible from propagating information from /proc/mounts to
> /var/whatever.

    In an embedded system I built a time ago, /etc/mtab was first a
symlink to /proc/mounts, but after a while I made it a symlink to
/var/run/mtab. It worked OK, AFAIK.

    Raúl
