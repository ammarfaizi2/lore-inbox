Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263713AbRFLWrG>; Tue, 12 Jun 2001 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRFLWq4>; Tue, 12 Jun 2001 18:46:56 -0400
Received: from elin.scali.no ([195.139.250.10]:49681 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263713AbRFLWqo>;
	Tue, 12 Jun 2001 18:46:44 -0400
Message-ID: <3B269B5D.35A554A9@scali.no>
Date: Wed, 13 Jun 2001 00:44:45 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Functionality of mmap, nopage and remap_page_range
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel list readers,

I have a question about the functionality of mmap(), vma->vm_ops functions and different
vma->vm_flags. Is there any documentation that describes these methods and how they should
work (i.e when should mmap() use remap_page_range and when is the vma->vm_ops->no_page
function called)

Any  help appreciated.
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
