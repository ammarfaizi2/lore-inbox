Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTA1Tiu>; Tue, 28 Jan 2003 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTA1Tiu>; Tue, 28 Jan 2003 14:38:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265099AbTA1Tiu>;
	Tue, 28 Jan 2003 14:38:50 -0500
Date: Tue, 28 Jan 2003 11:42:05 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jamie Lokier <jamie@shareable.org>
cc: Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Davide Libenzi <davidel@xmailserver.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030122080322.GB3466@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Jamie Lokier wrote:

| ps.  sys_* system-call functions should never return "int".  They
| should always return "long" or a pointer - even if the user-space
| equivalent returns "int".  Take a look at sys_open() for an example.
| Technical requirement of the system call return path on 64-bit targets.

Is this a blanket truism?  For all architectures?

Should current (older/all) syscalls be modified, or should only new ones
(like epoll) be corrected?

Thanks,
-- 
~Randy

