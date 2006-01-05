Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWAEMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWAEMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWAEMq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:46:26 -0500
Received: from drugphish.ch ([69.55.226.176]:9625 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1750799AbWAEMq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:46:26 -0500
Message-ID: <43BD156E.8090601@drugphish.ch>
Date: Thu, 05 Jan 2006 13:47:42 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Leonard Milcin Jr." <leonard.milcin@post.pl>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch> <43BD09F4.2090603@post.pl>
In-Reply-To: <43BD09F4.2090603@post.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> http://www.drugphish.ch/patches/ratz/bash/bash-3.0-fix_1439-3.diff
>>
>> But http://ttyrpld.sourceforge.net/ looks indeed interesting, however 
>> no 2.4.x support from what I can see.
>
> This can be very easily circumvented if you can execute another shell 
> (for example your own version of bash without patch).

Everything can be circumvented, but that's hardly the point of what the 
patch tries to achieve. It is/was actually a requirement for financial 
institutes, governments and ISPs running Linux-based services to comply 
to the SOX and Basel II acts. Besides, ttyrpld can also be cirumvented 
on a normal Linux distribution without special countermeasures or 
policies regarding kernel module loading. It's just a tad bit harder to do.

The cited patch has auditing and trace facilities up to the point where 
no intended malicious actions happen. It's only there to log and not to 
prevent any kind of attack.

Some of our systems for example run a highly secured Linux distribution 
(Pitbull LX, SELinux, RSBAC, and partially other compartmentalized 
environments), but some of those enhanced security systems do not 
provide sufficient logging mechanisms to comply to those new acts.

The reason I mentioned my patch is that it's non-intrusive, and this 
helps in case of a security certification, and maybe also otherwise. YMMV.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
