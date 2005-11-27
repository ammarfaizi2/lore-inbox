Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVK0XOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVK0XOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVK0XOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 18:14:33 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:28872 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751124AbVK0XOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 18:14:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] 2.6.15-rc2-ck2 with adaptive readahead: processes stuck in D state
Date: Mon, 28 Nov 2005 10:14:13 +1100
User-Agent: KMail/1.8.3
Cc: Frederik <freggy@gmail.com>, linux-kernel@vger.kernel.org,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
References: <28d495d10511271151lcac4998w292dff6e677130bc@mail.gmail.com>
In-Reply-To: <28d495d10511271151lcac4998w292dff6e677130bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511281014.13780.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005 06:51, Frederik wrote:
> Today I compiled 2.6.15-rc2-ck2 kernel with adaptive readahead patch
> v.8. The system is running Mandriva Cooker. With this kernel, it
> occured two times to me, that urpmi --auto-select starts hanging, and
> ps shows several processes stuck in D state (such as ldconfig).
>
> I am using XFS for all file systems, I'm wondering if it is related to
> this, because I see several XFS methods mentioned in the trace.
>
> I have put dmesg, config and the trace online on
> http://users.telenet.be/fhimpe/kernelbug/

I've cc'ed Wu on this reply. I should have made it clear that was the only way 
adaptive readahead feedback would be helpful.

Cheers,
Con
