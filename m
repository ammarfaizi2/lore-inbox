Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUGWNno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUGWNno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 09:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUGWNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 09:43:44 -0400
Received: from mail5.iserv.net ([204.177.184.155]:21930 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S267720AbUGWNnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 09:43:43 -0400
Message-ID: <4101161F.3060905@didntduck.org>
Date: Fri, 23 Jul 2004 09:43:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Move modpost files to a new subdir [1/2]
References: <40FFB68D.1000106@quark.didntduck.org> <20040723151630.GA6914@mars.ravnborg.org>
In-Reply-To: <20040723151630.GA6914@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Jul 22, 2004 at 08:43:57AM -0400, Brian Gerst wrote:
> 
>>This patch simply moves modpost-related files to a seperate subdirectory.
> 
> 
> I did this in my local tree but decided for a different directory name.
> Usage of modpost would conflict with the modpost binary and I suspected
> that some systems would not allow this clash.
> I do not expect people to run make mrproper before applying a patch..
> 
> The new directory name is: scripts/mod - also signalling that this can be
> used for other module related utilities in the future.
> 
> 	Sam
> 

scripts/modules would be more descriptive.

--
				Brian Gerst
