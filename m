Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTEaUze (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTEaUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:55:33 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:51663 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S264449AbTEaUz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:55:28 -0400
Message-ID: <3ED919DC.6030202@cox.net>
Date: Sat, 31 May 2003 14:08:44 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "ismail (cartman) donmez" <kde@myrealbox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
References: <3ED8D5E4.6030107@cox.net> <200305312325.07809.kde@myrealbox.com> <3ED91161.1050603@cox.net> <200305312358.03208.kde@myrealbox.com>
In-Reply-To: <200305312358.03208.kde@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail (cartman) donmez wrote:

> On Saturday 31 May 2003 23:32, Kevin P. Fleming wrote:
> 
>>See the beginning of my message... it only does so if _KERNEL_ is
>>defined. Since other header files also directly include compiler.h even
>>though they already include kernel.h, I didn't think this was an
>>unreasonable solution (i.e. they must have done it for the same reason,
>>since there are comments specifically about including compiler.h for
>>"__user").
>>
> 
> 
> Thats a bigger problem and should be solved like  ( imho ) with higher level 
> of kernel api which provides userspace apps kernel level operations.
> 

Right. But until such time as that happens (even if started today that's 
many months away), real world libraries need to be compiled to be used 
against the new kernel.

