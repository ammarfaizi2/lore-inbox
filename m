Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbULATQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbULATQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbULATQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:16:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:25750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbULATQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:16:21 -0500
Date: Wed, 1 Dec 2004 11:16:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Newman <cachehit@gmail.com>
Cc: linux-kernel@vger.kernel.org, mhenderson@pointserve.com
Subject: Re: kernel crashes with 2.5/2.8
Message-ID: <20041201111617.M14339@build.pdx.osdl.net>
References: <abc339820412010909325c08b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <abc339820412010909325c08b6@mail.gmail.com>; from cachehit@gmail.com on Wed, Dec 01, 2004 at 11:09:13AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Newman (cachehit@gmail.com) wrote:
> Nov 24 21:34:10 ptscorp-nis01 kernel: Unable to handle kernel paging
> request at virtual address 01000004

Possible bad memory.  This could be 4 byte offset of NULL with one bit
flipped.  Have you run memtest86?

Also, it'd be useful to keep tabs on the Oopsen.  Are they totally
random, same location, etc.

thanks,
-chris
