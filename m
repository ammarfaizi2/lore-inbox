Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135728AbRAJPDq>; Wed, 10 Jan 2001 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135731AbRAJPDg>; Wed, 10 Jan 2001 10:03:36 -0500
Received: from smtp2.libero.it ([193.70.192.52]:14576 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S135728AbRAJPDX>;
	Wed, 10 Jan 2001 10:03:23 -0500
Date: Wed, 10 Jan 2001 18:03:22 +0100
From: antirez <antirez@invece.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: antirez@invece.org, linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110180322.T7498@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <20010110174859.R7498@prosa.it> <3A5C778C.CFB363F3@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5C778C.CFB363F3@didntduck.org>; from bgerst@didntduck.org on Wed, Jan 10, 2001 at 09:54:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 09:54:04AM -0500, Brian Gerst wrote:
> This patch isn't really necessary, because GCC will automatically
> convert multiplications and divisions by powers of two to use shifts.

Sure, but since many << 2 already exists in the net kernel code
I feel it's better to use just a format, and it seems more appropriate
to write << 2, just to reflect what we want.
Also some piece of kernel code may be used with compilers that does not
optimize power of two.

antirez
(CC me)

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
