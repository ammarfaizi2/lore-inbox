Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDEDKb>; Thu, 4 Apr 2002 22:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312219AbSDEDKY>; Thu, 4 Apr 2002 22:10:24 -0500
Received: from pcp01384392pcs.walngs01.pa.comcast.net ([68.80.48.29]:25745
	"EHLO dysonwi") by vger.kernel.org with ESMTP id <S312181AbSDEDKF>;
	Thu, 4 Apr 2002 22:10:05 -0500
Message-ID: <3CAD158C.3040301@pobox.com>
Date: Thu, 04 Apr 2002 22:10:04 -0500
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020402 Debian/2:0.9.9-4
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: vcd, .dat files and isofs problem
In-Reply-To: <E16tDuI-0006jc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I have problems reading the .dat files from VCD, here is the kernel 
>>logs. I think it is an fs issue, since I am not the only one having the 
>>same problem. In user space, read returns I/O error but I think it is an 
>>fs issue or a cd-rom

Have a look at cdfs: http://www.elis.rug.ac.be/~ronsse/cdfs/

It will allow you to read those files. Of course, there are also userland 
  utilities for that. Just search freshmeat for vcd.

> VCD .dat files are not normal "files". They are encoded in a different mode
> to get more bytes/sector at the cost of lower error resistance (mpeg is
> error resistant in itself...)

I knew they were different, but not why. Learn something new every day.

-- 
Will Dyson

