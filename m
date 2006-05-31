Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWEaXbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWEaXbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWEaXbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:31:11 -0400
Received: from bobcat.it.wsu.edu ([134.121.0.132]:52703 "EHLO
	bobcat.it.wsu.edu") by vger.kernel.org with ESMTP id S965260AbWEaXbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:31:09 -0400
Message-ID: <447E2726.8020507@sandall.us>
Date: Wed, 31 May 2006 16:30:46 -0700
From: Eric Sandall <eric@sandall.us>
Organization: Source Mage GNU/Linux
User-Agent: Mail/News 1.5.0.2 (X11/20060427)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Mattia Dongili <malattia@linux.it>
Subject: Re: cpufreq and kernel >2.6.15.6 is limited
References: <6imLa-3G2-11@gated-at.bofh.it> <6in4s-44o-13@gated-at.bofh.it> <447D12D3.9050306@shaw.ca>
In-Reply-To: <447D12D3.9050306@shaw.ca>
X-Enigmail-Version: 0.93.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert Hancock wrote:
> Dave Jones wrote:
>> On Tue, May 30, 2006 at 05:25:26PM -0700, Eric Sandall wrote:
>>  >  > It seems that any kernel on my Dell Inspiron 5100 after 2.6.15.6
>>  > (including 2.6.17-rc5) 'breaks' my cpufreq in that up to and including
>>  > 2.6.15.6 I can scale between 300MHz-2.4GHz, but after (starting with
>>  > 2.6.16) I can only scale between 2.1GHz and 2.4GHz.
>>  >  > I've attached the files, sorted by kernel, I assume may be
>> helpful. Let
>>  > me know if you need any more.
>>
>> It may have worked in the past, but the CPU has an errata which makes
>> it an unsafe operation to scale below 2GHz.
> 
> There was some discussion about whether this was correct or not in this
> thread:
> 
> http://groups.google.ca/group/fa.linux.kernel/browse_thread/thread/d5b5905d7f1aa221/66c41ee3a26583b3
> 
> 
> Did this ever get resolved? From my reading of the N60 erratum,
> disabling the 12.5% duty cycle sounds like this should be enough,
> disabling everything under 2GHz is not necessary..

I would definitely prefer that approach of removing the problem
frequency rather than all 8.

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEficmHXt9dKjv3WERAhMqAJ9u9AMHd+X/eQ5FxgrHF7BF+Gd+FgCfY9JR
PFtmAt7+9z+CO6KnZw3sxeI=
=3qP/
-----END PGP SIGNATURE-----
