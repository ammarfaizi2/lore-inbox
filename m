Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbULLVuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbULLVuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbULLVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:50:31 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:18475 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262136AbULLVuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:50:24 -0500
Date: Sun, 12 Dec 2004 23:51:10 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: how to detect a 32 bit process on 64 bit kernel
Message-ID: <20041212215110.GA11451@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907121418.GC25051@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Is there a reliable way e.g. on x86-64 (or ia64, or any other
64-bit system), from the char device driver,
to find out that I am running an operation in the context of a 32-bit
task?

If no - would not it make a sence to add e.g. a flag in the
task struct, to make it possible?

Thanks,
MST
