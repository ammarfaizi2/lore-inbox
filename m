Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTARLvJ>; Sat, 18 Jan 2003 06:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTARLvJ>; Sat, 18 Jan 2003 06:51:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32961 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264657AbTARLvI>;
	Sat, 18 Jan 2003 06:51:08 -0500
Date: Sat, 18 Jan 2003 03:49:49 -0800 (PST)
Message-Id: <20030118.034949.121267176.davem@redhat.com>
To: jamie@shareable.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Bug? Sparc linux defines MAP_LOCKED == MAP_GROWSDOWN
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030118085331.GB19390@bjl1.asuk.net>
References: <20030118032940.GB18282@bjl1.asuk.net>
	<20030118.001218.52982745.davem@redhat.com>
	<20030118085331.GB19390@bjl1.asuk.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jamie Lokier <jamie@shareable.org>
   Date: Sat, 18 Jan 2003 08:53:31 +0000
   
   I.e. I suggest renumbering MAP_GROWSDOWN in <asm-sparc{,64}/mman.h>.
   Nobody in userspace will be using that, whereas there probably are a
   few programs using MAP_LOCKED, and getting MAP_GROWSDOWN behaviour as
   a bonus is a genuine bug.

I agree.
