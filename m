Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVIBG4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVIBG4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVIBG4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:56:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:11500 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030401AbVIBG4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:56:14 -0400
Message-ID: <4317F774.3000506@namesys.com>
Date: Fri, 02 Sep 2005 10:55:48 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050902003915.GI3657@stusta.de>
In-Reply-To: <20050902003915.GI3657@stusta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Adrian Bunk wrote:
> 4Kb kernel stacks are the future on i386, and it seems the problems it
> initially caused are now sorted out.
> 
> Does anyone knows about any currently unsolved problems?
> 
> I'd like to:
> - get a patch into on of the next -mm kernels that unconditionally 
>   enables 4KSTACKS
> - if there won't be new reports of breakages, send a patch to
>   completely remove !4KSTACKS for 2.6.15
> 
> In -mm, Reiser4 still has a dependency on !4KSTACKS.
> I've mentioned this at least twice to the Reiser4 people, and they 
> should check why this dependency is still there and if there are still 
> stack issues in Reiser4 fix them.
> 

We are about to send reiser4 update which makes it to not depend on !4kstack.

> If not people using Reiser4 on i386 will have to decide whether to 
> switch the filesystem or the architecture...
> 
> cu
> Adrian
> 

