Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965829AbWKEEHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965829AbWKEEHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965830AbWKEEHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:07:11 -0500
Received: from wasp.net.au ([203.190.192.17]:59871 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S965829AbWKEEHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:07:09 -0500
Message-ID: <454D6333.9050209@wasp.net.au>
Date: Sun, 05 Nov 2006 08:06:11 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Manu Abraham <abraham.manu@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdb lost interrupt
References: <4549B305.7040106@gmail.com> <1162473087.11965.182.camel@localhost.localdomain> <454A0F2B.5060603@gmail.com>
In-Reply-To: <454A0F2B.5060603@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham wrote:

> 196 Reallocated_Event_Count 0x0032   199   199   000    Old_age   Always
>       -       1
> 197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always
>       -       5

You have grown defects pending reallocation. A read to any one of these will cause the drive to 
return an error.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
