Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBKDQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 22:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUBKDQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 22:16:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:44940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbUBKDQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 22:16:29 -0500
Date: Tue, 10 Feb 2004 19:19:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Critical problem in 2.6.2 and up
Message-Id: <20040210191911.4d6e1308.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
References: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
>
> # lilo
> 
>  Warning: '/proc/partitions' does not match '/dev' directory structure.
>      Name change: '/dev/nbd0' -> '/tmp/dev.0'
>  Warning: '/dev' directory structure is incomplete; device (43, 0) is missing.
>  Warning: '/dev' directory structure is incomplete; device (43, 1) is missing.
>  Warning: '/dev' directory structure is incomplete; device (43, 2) is missing.
>  Warning: '/dev' directory structure is incomplete; device (43, 3) is missing.

Please send us your /proc/partitions with, and without that patch.

If you disable nbd in config, does it help?

Are you using devfs?
