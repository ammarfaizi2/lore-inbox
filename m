Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUFQNr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUFQNr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUFQNr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:47:28 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50445 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266494AbUFQNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:47:25 -0400
Message-ID: <40D1A502.9070403@techsource.com>
Date: Thu, 17 Jun 2004 10:04:50 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: davids@webmaster.com, erikharrison@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
References: <MDEHLPKNGKAHNMBLJOLKIEKKMKAA.davids@webmaster.com> <200406170045.32844.oliver@neukum.org>
In-Reply-To: <200406170045.32844.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oliver Neukum wrote:
> Am Mittwoch, 16. Juni 2004 23:21 schrieb David Schwartz:
> 
>>    b) You must cause any work that you distribute or publish, that in
>>    whole or in part contains or is derived from the Program or any
>>    part thereof, to be licensed as a whole at no charge to all third
>>    parties under the terms of this License.
>>
>>        How can you cause the Linux kernel combined with this firmware to be
>>licensed under the terms of the GPL? (And, by the way, I think this
>>prohibits trademark as well, which is very interesting.)
> 
> 
> This all boils down to the question of whether fimware is code or not.
> As this question is extremely unlikely to be resolved on this list and
> was discussed here several times already, I kindly request that
> you take this discussion to a legalistic list and confine traffic of this
> kind on this list to clear and technical issues.


If you consider firmware to be "part of the hardware", then it's no 
different from having a table of register values to write to a 
peripheral whose meaning just isn't documented anywhere.

Remember the big up-roar about how Sun would not release information to 
one of the BSD teams so that they could port to UltraSparc III?  Well, 
they'd given that information to a Linux developer, and you can look at 
the source code if you like, but it isn't MEANINGFUL in a way that lets 
someone examine it to understand it to be able to reimplement it for a 
different OS.

With the case of the firmware, since the code there is only meaningful 
to the hardware you load it into, and that code doesn't execute on the 
host processor, this may create a sort of conceptual barrier which 
insulates the firmware code from NEEDING to be "open source".

Or to put it another way, you might consider a hex representation of the 
firmware that is embedded in the kernel to be the "preferred form", and 
its license is no more relevant than the license applied to the Verilog 
source to an ASIC for which you DON'T have to load firmware.

Lawyers could have a great fun time with this.  :)

