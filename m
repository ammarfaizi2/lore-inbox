Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSK0Jwg>; Wed, 27 Nov 2002 04:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSK0Jwg>; Wed, 27 Nov 2002 04:52:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261857AbSK0Jwf>;
	Wed, 27 Nov 2002 04:52:35 -0500
Date: Wed, 27 Nov 2002 01:57:17 -0800 (PST)
Message-Id: <20021127.015717.91758081.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: ak@muc.de, sfr@canb.auug.org.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15844.34389.396428.645047@napali.hpl.hp.com>
References: <15844.31669.896101.983575@napali.hpl.hp.com>
	<20021127082918.GA5227@averell>
	<15844.34389.396428.645047@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Wed, 27 Nov 2002 00:46:13 -0800
   
   The user-space won't, but the kernel exit path might.

You need to have a different kernel exit path, you need
a different one to chop off the top 32-bits of all the
incoming arguments anyways David.
