Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265614AbSJSQRZ>; Sat, 19 Oct 2002 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265615AbSJSQRZ>; Sat, 19 Oct 2002 12:17:25 -0400
Received: from [217.19.40.15] ([217.19.40.15]:64016 "EHLO ostry.com")
	by vger.kernel.org with ESMTP id <S265614AbSJSQRY>;
	Sat, 19 Oct 2002 12:17:24 -0400
Message-ID: <3DB1874F.2030007@weselyb.net>
Date: Sat, 19 Oct 2002 18:24:47 +0200
From: Bernhard Wesely <lll@weselyb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1b) Gecko/20020721
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NatSemi Geode improvement
References: <20021017171217.4749211782A@triton2> <20021017192041.B17285@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 18, 2002 at 02:12:17AM +0900, Hiroshi Miura wrote:
> 
>  > NatSemi Geode has a several feature to speed up,
>  > but reset defalut value is set to slow side.
>  > 
>  > I make a patch to speed up Geode about 20-40%!!
>  > the benchmark result is downloadable from http://www.da-cha.org/geode/geode_graph.sxc.
>  > that is openoffice format.
>  > 
>  > I use this patch with 2.4.18, 2.4.19 in 4 month, I think it is stable enough.
> 
> Previously these tweaks were done in userspace with the set6x86 utility.
> Is there any reason that these need to be done in the kernel apart from
> convenience ?
> 

Maybe not, but as this patch alters the initialization of the CPU to 
(seems to me) more useful values, it should be integrated into the 
Kernel. Not everyone knows of "set6x86".

Just my thoughts.

>         Dave
> 

Bernie

