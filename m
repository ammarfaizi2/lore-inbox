Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSGOLpv>; Mon, 15 Jul 2002 07:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSGOLpu>; Mon, 15 Jul 2002 07:45:50 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:50192 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S317443AbSGOLpt>; Mon, 15 Jul 2002 07:45:49 -0400
Message-ID: <3D326D5E.B2D228C0@opersys.com>
Date: Mon, 15 Jul 2002 02:36:14 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Manik Raina <manik@cisco.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, 2.5] : Adding counters to BSD process accounting
References: <Pine.GSO.4.44.0207151154460.23890-100000@cbin2-xdm1.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manik Raina wrote:
> This  patch  keeps account of the number of bytes read/written by a
> process in it's lifetime.
> 
> This may be a  good estimate of how IO bound a process is.
> This change is integrated with the BSD process accounting feature. Please
> review the changes and if you're ok with it, please apply to the 2.5 tree.

This is yet another piece of information LTT already provides. If you're
interested in analyzing the I/O operations carried out by a process and
how these operations influence other processes' I/O, then LTT is a very
good place to look.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
