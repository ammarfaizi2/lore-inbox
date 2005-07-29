Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVG2AR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVG2AR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVG2AR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:17:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40440 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261575AbVG2AQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:16:19 -0400
Message-ID: <42E9753A.5090407@mvista.com>
Date: Thu, 28 Jul 2005 17:15:54 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
References: <42E97236.6080404@mvista.com> <20050729101350.G3437507@wobbly.melbourne.sgi.com>
In-Reply-To: <20050729101350.G3437507@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Thu, Jul 28, 2005 at 05:03:02PM -0700, Mark Bellon wrote:
>  
>
>>The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 
>>    
>>
>
>The XFS component is incorrect, we're already doing this elsewhere
>(over in fs/xfs/quota/xfs_qm_bhv.c), so please drop this last part
>from your patch...
>  
>
No problem! New patch coming up.

mark

>  
>
>>diff -Naur linux-2.6.13-rc3-git9-orig/fs/xfs/xfs_vfsops.c linux-2.6.13-rc3-git9/fs/xfs/xfs_vfsops.c
>>...
>>+		{ XFS_UQUOTA_ACTIVE,		"," "usrquota" },
>>+		{ XFS_GQUOTA_ACTIVE,		"," "grpquota" },
>>    
>>
>
>thanks.
>
>  
>

