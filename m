Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTARINc>; Sat, 18 Jan 2003 03:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTARINc>; Sat, 18 Jan 2003 03:13:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264628AbTARINb>;
	Sat, 18 Jan 2003 03:13:31 -0500
Date: Sat, 18 Jan 2003 00:12:18 -0800 (PST)
Message-Id: <20030118.001218.52982745.davem@redhat.com>
To: jamie@shareable.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Bug? Sparc linux defines MAP_LOCKED == MAP_GROWSDOWN
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030118032940.GB18282@bjl1.asuk.net>
References: <20030118032940.GB18282@bjl1.asuk.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jamie Lokier <jamie@shareable.org>
   Date: Sat, 18 Jan 2003 03:29:40 +0000

   On Sparc and Sparc64, MAP_LOCKED and MAP_GROWSDOWN are both defined
   as 0x100.  This is a bug, isn't it?
   
Unfortunately it's one we're going to have to live with somehow.
Probably by just saying MAP_GROWSDOWN is totally unsupported.
I see no real use for it anyways.
