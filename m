Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVG1X4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVG1X4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVG1X4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:56:51 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:22029 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261497AbVG1X4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:56:50 -0400
Message-ID: <42E970BE.1040004@snapgear.com>
Date: Fri, 29 Jul 2005 09:56:46 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>	<buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>	<42E896EC.7030503@ppp0.net> <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp> <42E8CE48.5090301@snapgear.com> <42E92B7B.8080304@ppp0.net>
In-Reply-To: <42E92B7B.8080304@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Jan Dittmer wrote:
> Greg Ungerer wrote:
> 
>>>If you care to try applying the uClinux patches, they should be available
>>
>>>from (fill in "$ver" with "2.6.12-uc0" and "$maj_ver" with "2.6"):
>>
>>>   http://www.uclinux.org/pub/uClinux/uClinux-$maj_ver.x/linux-$ver.patch.gz
>>>
>>>Greg, do you have any status on merging the current uClinux patch set?
>>
>>
>>I sent a bunch of the 2.6.12-uc0 changes to Linus earlier this week
>>(the critical fixes), but according to his GIT log he didn't merge them.
>>I am going to resend tomorrow.
> 
> 
> Greg you might consider adding the attached patch to update the defconfig for
> m68nommu, especially
> 
> +#
> +# Console display driver support
> +#
> +# CONFIG_VGA_CONSOLE is not set
> +CONFIG_DUMMY_CONSOLE=y
> 
> which allows the m68knommu defconfig to be buildable without further invention.
> Patch is against 2.6.12-uc0

Done. I'll add it to my list of patches to send.

Regards
Greg



-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
