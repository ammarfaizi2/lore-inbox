Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290773AbSAYWAk>; Fri, 25 Jan 2002 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290821AbSAYWAY>; Fri, 25 Jan 2002 17:00:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5267 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290773AbSAYWAM>;
	Fri, 25 Jan 2002 17:00:12 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201252159.g0PLxun17423@eng2.beaverton.ibm.com>
Subject: BIO usage questions
To: axboe@suse.de, linux-kernel@vger.kernel.org, andrea@suse.de
Date: Fri, 25 Jan 2002 13:59:56 -0800 (PST)
Cc: pbadari@us.ibm.com, suparna@in.ibm.com, gerrit@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have few questions on usage of "bio" in 2.5.X.

1) It is acceptable to use "bio" instead of "kio" for doing RAW IO
   and direct IO ? Currently, "kio" are getting converted to "bio"
   anywhy. why not use "bio" directly ?

   I am planning to do this. But I was wondering what are the issues
   here.

2) I don't see how to wait for a "bio" to complete. I don't see any
   wait_queue in bio structure. How can I wait for bio to complete ?

Please let me know.

Thanks,
Badari
 
