Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSKCPZh>; Sun, 3 Nov 2002 10:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSKCPZh>; Sun, 3 Nov 2002 10:25:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6039 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262033AbSKCPZh>; Sun, 3 Nov 2002 10:25:37 -0500
Date: Sun, 03 Nov 2002 07:28:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: vasya vasyaev <vasya197@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
Message-ID: <3700636383.1036308528@[10.10.2.3]>
In-Reply-To: <20021103141753.50480.qmail@web20503.mail.yahoo.com>
References: <20021103141753.50480.qmail@web20503.mail.yahoo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any ideas ? need more info?

Can you profile it? Either get the oprofile patch, or put
"profile=2" on the kernel command line, and use readprofile
(built in). You'll have to search around for more extensive
instructions, but hopefully that'll tell you what's burning
the CPU time.

M.



