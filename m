Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJSTMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTJSTMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:12:32 -0400
Received: from mail.skjellin.no ([80.239.42.67]:44708 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262063AbTJSTMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:12:31 -0400
Subject: Re: Mounting /dev/md0 as root in 2.6.0-test7
From: Andre Tomt <andre@tomt.net>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1ABIg9-0003s2-00@penngrove.fdns.net>
References: <E1ABIg9-0003s2-00@penngrove.fdns.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1066590757.498.3.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 21:12:37 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-19 at 20:53, John Mock wrote:
> The basic problem here is that the kernel has no idea what disks comprise
> your RAID when you just say "root=/dev/md0", e.g., it has no idea where to
> start. 

The kernel knows it if the array is set up with persistent superblocks,
the partition type of the relevant partitions has id 0xfd (raid
auto-detect), and the md-raid code is compiled into the kernel image.

-- 
Mvh,
André Tomt
andre@tomt.net

