Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTDTVAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTDTVAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:00:21 -0400
Received: from rth.ninka.net ([216.101.162.244]:35029 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263696AbTDTVAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:00:20 -0400
Subject: Re: [PATCH] new system call mknod64
From: "David S. Miller" <davem@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200304202034.h3KKYct01306.aeb@smtp.cwi.nl>
References: <UTC200304202034.h3KKYct01306.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050873133.26264.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Apr 2003 14:12:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-20 at 13:34, Andries.Brouwer@cwi.nl wrote:
> Yesterday or the day before Linus preferred __u32 etc for this
> loopinfo64 ioctl, so I did it that way. Here, since mknod is a
> traditional Unix system call, I am still inclined to prefer
> (unsigned) int above __u32.  Of course it doesn't matter much.

To 64-bit platforms implementing 32-bit compatability layers,
it can matter a ton to use portable vs. non-portable types.

-- 
David S. Miller <davem@redhat.com>
