Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWJLUXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWJLUXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWJLUXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:23:33 -0400
Received: from alnrmhc13.comcast.net ([206.18.177.53]:15577 "EHLO
	alnrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750729AbWJLUXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:23:32 -0400
Message-ID: <452EA441.6070703@comcast.net>
Date: Thu, 12 Oct 2006 16:23:29 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com>
In-Reply-To: <452E9E47.8070306@nortel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Chris Friesen wrote:
> John Richard Moser wrote:
> 
>> Linux ported onto the L4-Iguana microkernel is reported to be faster
>> than the monolith[1]; it's not like microkernels are faster, but the
>> L4-Iguana apparently just has super awesome context switching code:
>>
>>    Wombat's context-switching overheads as measured by lmbench on an
>>    XScale processor are up to thirty times less than those of native
>>    Linux, thanks to Wombat profiting from the implementation of fast
>>    context switches in L4-embedded.
> 
> The Xscale is a fairly special beast, and it's context-switch times are
> pretty slow by default.
> 
> Here are some context-switch times from lmbench on a modified 2.6.10
> kernel. Times are in microseconds:
> 
> cpu        clock speed    context switch   
> pentium-M    1.8GHz        0.890
> dual-Xeon    2GHz        7.430
> Xscale        700MHz        108.2
> dual 970FX    1.8GHz        5.850
> ppc 7447    1GHz        1.720
> 
> Reducing the Xscale time by a factor of 30 would basically bring it into
> line with the other uniprocessor machines.
> 

That's a load more descriptive :D

0.890 uS, 0.556uS/cycle, that's barely 2 cycles you know.  (Pentium M)
PPC performs similarly, 1 cycle should be about 1uS.

> Chris
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS6kPws1xW0HCTEFAQJnAhAAloJ1KvztR+CiKSvBEvEHUcoUm9HwxpaE
WrTKrBxEV36VXgHVzJsqvs6YLzyLhyLWv2YFKlPS6iYyKvwO3v8P54fVPLqZAcAn
7VSAml9wSRt1woh1MxwApDlQO/snf5rAV/+1cuCGXKmpqLAHCGjrMJgn5TEbknCG
9H4Ie5Db6541lO7Zw5rouas03wLVPUU831UCTKJi8ngyx30FNDeaDds9EeYA0Ox/
5gEOVavkHRV5AJ6GhGtmgEpTdB69oB6nwv07UtuYN7QKC2tJ0E7tomuLeh4mbMM9
N5rV9Q+KzL955HINqQPe5+pF31+W4fQ4zKBzyyz0AQ6BHkyu+v9B371HuIo5RCeV
adC5p17PM5Ms819bfB0Nl6WjRhje5ybTDHyKxiNEHQL7T+LCkCjJvDvkeIr33aS2
vcAlFQvk8RYz5bZn1dsJpXfYc0GPH9M93Zf3dOr8syPmzOCFlD3MgWJvcTGlg2fT
Lxg5e8MBfjwyZ1XYBouFaY4GlytaebCXT5jXlutZDYQfIIIsHhQ2BV3xCcr2jP5K
Q1UmOld8GB+HeHmfvge3/5gXWIQxZx/vgNEm+XPUQk7j0Ei9E4yy/MVdXdx4GKDv
uNbclRT3xOlYhsbabGsxunCRok6Ph4eTQPmT3YLO+rpxLq1vyGDW3+kEca6+yCIp
WEBb7mlPRaw=
=pvD8
-----END PGP SIGNATURE-----
