Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285507AbRLGUme>; Fri, 7 Dec 2001 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLGUmZ>; Fri, 7 Dec 2001 15:42:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285507AbRLGUmI>;
	Fri, 7 Dec 2001 15:42:08 -0500
Date: Fri, 07 Dec 2001 12:42:02 -0800 (PST)
Message-Id: <20011207.124202.48805183.davem@redhat.com>
To: ak@suse.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.kernel>
	<9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
	<p73n10v6spi.fsf@amdsim2.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 07 Dec 2001 14:54:49 +0100
   
   It is a common problem on all OS that eventually got threadsafe stdio. 
   I bet putc sucks on Solaris too.

Nope, they even inline the full implementation it in their header
files so they beat even our putc_unlocked() to the point it is
embarassing.
