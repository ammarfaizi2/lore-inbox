Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVFHMCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVFHMCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVFHMCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:02:53 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:16787 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262188AbVFHMAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:00:37 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Vladimir Saveliev <vs@namesys.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <20050607212706.GB7962@stusta.de>
References: <20050607212706.GB7962@stusta.de>
Content-Type: text/plain
Message-Id: <1118232016.3176.72.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 08 Jun 2005 16:00:16 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-06-08 at 01:27, Adrian Bunk wrote:
> 4Kb kernel stacks are the future on i386, and it seems the problems it 
> initially caused are now sorted out.
> 
> I'd like to:
> - get a patch into the next -mm that unconditionally enables 4KSTACKS
> - if there won't be new reports of breakages, send a patch to
>   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> 
> The only drawback is that REISER4_FS does still depend on !4KSTACKS.
> I told Hans back in March that this has to be changed.
> Is there any ETA until that all issues with 4Kb kernel stacks in Reiser4 
> will be resolved?
> 

yes, it should be ready to the end of this week.


> If not people using Reiser4 might have to decide whether to switch the 
> filesystem or the architecture...
> 
> cu
> Adrian

