Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSKLNxR>; Tue, 12 Nov 2002 08:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266319AbSKLNxQ>; Tue, 12 Nov 2002 08:53:16 -0500
Received: from mail.spylog.com ([194.67.35.220]:63906 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S261542AbSKLNxP>;
	Tue, 12 Nov 2002 08:53:15 -0500
Date: Tue, 12 Nov 2002 16:59:57 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20rc1aa1 - where inet_peer_* ?
Message-ID: <20021112135957.GA32246@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

linux-2.4.19-pre3aa2

/proc/sys/net/ipv4$ l inet_peer_*
-rw-r--r--    1 root     root            0 Nov 12 13:57 inet_peer_gc_maxtime
-rw-r--r--    1 root     root            0 Nov 12 13:57 inet_peer_gc_mintime
-rw-r--r--    1 root     root            0 Nov 12 13:57 inet_peer_maxttl
-rw-r--r--    1 root     root            0 Nov 12 13:57 inet_peer_minttl
-rw-r--r--    1 root     root            0 Nov 12 13:57 inet_peer_threshold


linux-2.4.20-rc1aa1

/proc/sys/net/ipv4$ l inet_peer_*
ls: inet_peer_*: No such file or directory


.config no change.

-- 
Any statement is incorrect.
