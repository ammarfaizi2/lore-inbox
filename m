Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318367AbSGaNbz>; Wed, 31 Jul 2002 09:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318371AbSGaNbz>; Wed, 31 Jul 2002 09:31:55 -0400
Received: from CPE-203-51-28-61.nsw.bigpond.net.au ([203.51.28.61]:46835 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S318367AbSGaNby>; Wed, 31 Jul 2002 09:31:54 -0400
Message-ID: <3D47E796.3188C62@eyal.emu.id.au>
Date: Wed, 31 Jul 2002 23:35:18 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
References: <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com> <004501c23841$03265a30$6a01a8c0@wa1hco>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar wrote:
[trimmed]
> Raid needs an automatic way to maintain device synchronization.  Why should
> I have to...
>     manually examine the device data (lsraid)
>     find two devices that match
>     mark the others failed in /etc/raidtab
>     reinitialize the raid devices...putting all data at risk
>     hot add the "failed" device
>     wait for it to recover (hours)

There is no need to wait here, go a head and remount it now if you need
it.

>     change /etc/raidtab again
>     retest everything

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
