Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUIJPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUIJPkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIJPjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:39:43 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58254 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267494AbUIJPjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:39:00 -0400
Message-ID: <4141CAAB.4020708@tmr.com>
Date: Fri, 10 Sep 2004 11:39:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
References: <Pine.LNX.4.44.0409091726010.2713-100000@einstein.homenet>
In-Reply-To: <Pine.LNX.4.44.0409091726010.2713-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> Hello,
> 
> I have received and tested the latest microcode data file from Intel, The
> file is dated 2nd September 2004. You can download it both as standalone
> (bzip2-ed) text file and bundled with microcode_ctl utility from the
> Download section of the website:
> 
> http://urbanmyth.org/microcode/
> 
> Please let me know if you find any problems with this data file or with
> the Linux microcode driver. Thank you.

Why are you using /dev/cpu/microcode instead of /dev/cpu/N/microcode for 
each CPU? Today they are all the same device, but for the future I would 
think this was an obvious CYA.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
