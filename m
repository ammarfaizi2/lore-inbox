Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUHIU6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUHIU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUHIU4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:56:39 -0400
Received: from ppp1-adsl-37.the.forthnet.gr ([193.92.232.37]:15655 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S267269AbUHIUqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:46:37 -0400
From: V13 <v13@priest.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Make scsi.h nominally userspace-clean
Date: Mon, 9 Aug 2004 23:48:33 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040809172406.GA1042@orchestra.cs.caltech.edu> <20040809175200.GA28126@suse.de>
In-Reply-To: <20040809175200.GA28126@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408092348.36583.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 20:52, Jens Axboe wrote:
> > I do not argue that including this header file in a program is
> > appropriate, but other kernel headers already take as many precautions
> > as this patch introduces.  I chose __u8 over uint8_t as more in the
> > style of the kernel generally.
> >
> > Please keep me on cc:; I do not subscribe to the lists.
>
> I already sent such a patch to Linus.

Do you accept patches like '#include <linux/compiler.h>' (for header file to 
be used by userspace) or was this an exception ? 

<<V13>>
