Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbTBNVdi>; Fri, 14 Feb 2003 16:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTBNU42>; Fri, 14 Feb 2003 15:56:28 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9736 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267547AbTBNUzz>;
	Fri, 14 Feb 2003 15:55:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302142106.h1EL6sbb004287@darkstar.example.net>
Subject: Re: creating incremental diffs
To: solt@dns.toxicfilms.tv (Maciej Soltysiak)
Date: Fri, 14 Feb 2003 21:06:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv> from "Maciej Soltysiak" at Feb 14, 2003 09:48:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> let's say i want to create an incremental diff between
> 2.4.21pre4aa1 and aa2.
> 
> how do i do that?

Something like:

cd /usr/src/
diff -rNu linux-2.4.21pre4aa1 linux-2.4.21pre4aa2 > patch

should do it.

John.
