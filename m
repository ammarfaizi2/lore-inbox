Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSFJVza>; Mon, 10 Jun 2002 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSFJVz3>; Mon, 10 Jun 2002 17:55:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54448 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316423AbSFJVz2>; Mon, 10 Jun 2002 17:55:28 -0400
Message-ID: <3D05204B.4010103@us.ibm.com>
Date: Mon, 10 Jun 2002 14:55:23 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: acenic >4gig sendfile problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing sendfile with my acenic card on my 8xPIII-700 and PAE 
running 2.4.18, I'm getting all zeros in the files being transmitted. 
  Running the Redhat 2.4.18-4 kernel fixes the problem.  I saw this 
entry in the rpm's changelog:
* Sat Aug 25 2001 Ingo Molnar <mingo@redhat.com>
- fix the acenic driver bug that caused random kernel memory being
    sent out on the wire, on x86 systems with more than 4 GB RAM.

I tried to pull the relevant bits out of
linux-2.4.17-selected-ac-bits.patch and linux-2.4.18-tg3.patch, with
no success.  I mailed Ingo with no response.

Does anybody remember what the fix was, or still have the patch handy?
-- 
Dave Hansen
haveblue@us.ibm.com


