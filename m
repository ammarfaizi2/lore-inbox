Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVG1MN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVG1MN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVG1MN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:13:57 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:59917 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261426AbVG1MNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:13:40 -0400
Message-ID: <42E8CE48.5090301@snapgear.com>
Date: Thu, 28 Jul 2005 22:23:36 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>	<buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>	<42E896EC.7030503@ppp0.net> <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp>
In-Reply-To: <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Miles Bader wrote:
> Jan Dittmer <jdittmer@ppp0.net> writes:
> 
>>>"v850e-elf".
>>
>>Thanks, that got me much further, compilation aborts now with
> 
> 
> Hmmm, what sources are you compiling exactly?
> 
> I last tested with 2.6.12 + 2.6.12-uc0 (uClinux) patches + the v850 patches
> I sent to the LKML recently (from which I presume you got the defconfigs);
> the v850 patches should now be merged into Linus's tree, but I dunno about
> the uClinux patches (and of course there may already be v850 breakage in
> Linus's current tree; I usually only test real releases).
> 
> If you care to try applying the uClinux patches, they should be available
> from (fill in "$ver" with "2.6.12-uc0" and "$maj_ver" with "2.6"):
> 
>     http://www.uclinux.org/pub/uClinux/uClinux-$maj_ver.x/linux-$ver.patch.gz
> 
> Greg, do you have any status on merging the current uClinux patch set?

I sent a bunch of the 2.6.12-uc0 changes to Linus earlier this week
(the critical fixes), but according to his GIT log he didn't merge them.
I am going to resend tomorrow.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
