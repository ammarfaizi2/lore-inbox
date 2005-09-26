Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbVIZQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbVIZQpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbVIZQpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:45:00 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:64008 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751673AbVIZQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:44:59 -0400
Message-ID: <4338258F.9080407@tmr.com>
Date: Mon, 26 Sep 2005 12:45:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /proc/sys/fs/file-nr and threads
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a high number of files open, and there is no other reasonable 
cause other than threads in a single server operating. The code is 
complex, and I'm asking if the number of files "open" is somehow being 
counted as files open by the parent times number of threads. I'm getting 
some various error returns on file open which could be caused by that.

Just looking for an answer for both 2.4 and 2.6 kernels, since this 
appears to be happening on both.

-- 
   -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
 last possible moment - but no longer"  -me

