Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVC3N0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVC3N0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVC3N0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:26:12 -0500
Received: from justchat.medium.net ([83.120.2.52]:2205 "EHLO
	smtp.mail.service.medium.net") by vger.kernel.org with ESMTP
	id S261888AbVC3N0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:26:07 -0500
Message-ID: <424AA8E8.1020008@baldauf.org>
Date: Wed, 30 Mar 2005 15:26:00 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a5) Gecko/20041122
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat: why is shortname=lower the default?
References: <4249BB5C.5000102@baldauf.org> <871x9xs2fy.fsf@devron.myhome.or.jp>
In-Reply-To: <871x9xs2fy.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.5 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

>Xuân Baldauf <xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org> writes:
>
>  
>
>>Why is shortname=lower the default mount option for vfat filesystems?
>>Because, with "shortname=lower", copying one FAT32 filesystem tree to
>>another FAT32 filesystem tree using Liux results in semantically
>>different filesystems. (E.g.: Filenames which were once "all
>>uppercase" are now "all lowercase").
>>    
>>
>
>The reason is only it's very long-standing behavior.  When this
>behavior was changed before, it seems an one user was confused at
>least.
>
>    http://marc.theaimsgroup.com/?t=97041869500002&r=1&w=2
>
>Personally I agree that "winnt" or "mixed" is proper.
>
>However, if we want to change the default behavior, it would need to
>be tested for some months, and if anyone has no objection it can
>change I think.
>  
>
One could make a slow transition, starting now with a warning like 
"vfat: warning: You are using "shortname=lower" as default. This may not 
be what you want. This default will change to "shortname=mixed" after 
2005-07-01." if the shortname behaviour is not explicitly selected.

>Thanks.
>  
>
ciao,
Xuân. :-)

P.S.: I'm now trying to recover about 4M files from "lost case"...

