Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290957AbSBLRmv>; Tue, 12 Feb 2002 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSBLRmk>; Tue, 12 Feb 2002 12:42:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17536 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290957AbSBLRmc>; Tue, 12 Feb 2002 12:42:32 -0500
Message-ID: <3C695401.8040503@us.ibm.com>
Date: Tue, 12 Feb 2002 09:42:25 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020202
X-Accept-Language: en-us
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove BKL from NFS read/write code + SunRPC...
In-Reply-To: <15465.476.953349.720240@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
 > The following patch strongly reduces BKL contention within the NFS
 > read/write code, and within the generic RPC layer.

Do you have any benchmarks which showed BKL contention in the NFS code? 
  I'm not trying to criticize, I think the patch is wonderful.  I want 
to have some more numbers to say, "Look!  The BKL _is_ bad!"

-- 
Dave Hansen
haveblue@us.ibm.com

