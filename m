Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281852AbRKREO3>; Sat, 17 Nov 2001 23:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281853AbRKREOT>; Sat, 17 Nov 2001 23:14:19 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:17397 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S281852AbRKREOA>; Sat, 17 Nov 2001 23:14:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Linux-2.4.15-pre5 - probably something wrong with /proc/cpuinfo.
Date: Sun, 18 Nov 2001 15:17:04 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111171907190.11475-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111171907190.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011118041410Z281852-17408+15618@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001 00:09, Alexander Viro wrote:
> Eww...  If anything, that's cat </proc/cpuinfo | while ...,
> but that's quite ugly.  Try the patch I've posted on l-k
> (Subject: [PATCH][CFT] seq_file and lseek).
Hello,

Thanks a lot. I have seen your patch included in Linux-2.4.15-pre6, and it 
does fix the issue.
-- 
Hari.
harisri@bigpond.com
