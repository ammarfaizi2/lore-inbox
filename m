Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSEWXVt>; Thu, 23 May 2002 19:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317045AbSEWXVs>; Thu, 23 May 2002 19:21:48 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:26039 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S317044AbSEWXVr>; Thu, 23 May 2002 19:21:47 -0400
Subject: Re: Reg. asm-sparc64/processor.h
From: Shanti Katta <katta@csee.wvu.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020522.205224.63641863.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 May 2002 19:24:35 -0400
Message-Id: <1022196275.2591.4.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-22 at 23:52, David S. Miller wrote:
> 
> If you want the 'u64' type, define __KERNEL__.  That is what
> every platform does, protect the types without underscores with
> a __KERNEL__ ifdef.
Hi,
In asm-sparc64/processor.h (2.4.18), in thread_struct structure, there
are 3 fields:
        u64 *user_cntd0, *user_cntd1;
        u64 kernel_cntd0, kernel_cntd1;
        u64 pcr_reg; 

which are defined without #ifdef __KERNEL__ . I guess, this is a bug,
which needs fixing.

Thanks
-Regards
-Shanti Katta

