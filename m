Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUELLcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUELLcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbUELLcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:32:43 -0400
Received: from [213.133.118.2] ([213.133.118.2]:16035 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265002AbUELLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:32:41 -0400
Message-ID: <40A20C76.40204@shadowconnect.com>
Date: Wed, 12 May 2004 13:37:26 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>, Warren Togami <wtogami@redhat.com>,
       Al Viro <viro@redhat.com>
Subject: [PATCH 2.6] i2o_proc converting from proc_read to seq_file with problems
 and request for help
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first, i didn't attach the patch because the size is 120k and it doesn't 
work at the moment. If you want it by e-mail, please let me know. 
Meanwhile you could download the patch from:

http://i2o.shadowconnect.com/testing/i2o_proc-seq_file.patch

The patch converts the proc_read function to the seq_file function 
(thanks to Al Viro for helping).

Only some functions are working without any problem (e. g. i2o_*_lct). 
But some others get a Segmentation fault (e. g. i2o_*_claimed). Strange 
about it is that the Segmentation fault occur after the function returns 
and the output is displayed normally.

If you want the output of the kernel for 32-bit UP and 64-bit SMP 
system, look at http://i2o.shadowconnect.com/testing/.

Any help what i done wrong would be appreciated.

Thank you very much.


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

