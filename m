Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVCOAWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVCOAWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVCOAUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:20:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:43235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262153AbVCOATX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:19:23 -0500
Message-ID: <423629FE.3070208@osdl.org>
Date: Mon, 14 Mar 2005 16:19:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] procfs: convert to C99 inits.
References: <20050314160329.456ce70b.rddunlap@osdl.org> <20050315001526.GC6903@home.fluff.org>
In-Reply-To: <20050315001526.GC6903@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On Mon, Mar 14, 2005 at 04:03:29PM -0800, Randy.Dunlap wrote:
> 
>>(resend)
>>
>>Use C99 struct inits as requested by sparse:
>>fs/proc/base.c:738:2: warning: obsolete struct initializer, use C99 syntax
>>fs/proc/base.c:739:2: warning: obsolete struct initializer, use C99 syntax
> 
> 
> I posted a patch for this, and an included `__user` missing
> from the self-same set of functions a short while ago.

Sounds better.  I hadn't noticed that part...

-- 
~Randy
