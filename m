Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbTCTUCs>; Thu, 20 Mar 2003 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCTUCs>; Thu, 20 Mar 2003 15:02:48 -0500
Received: from terminus.zytor.com ([63.209.29.3]:20966 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S261885AbTCTUCr>; Thu, 20 Mar 2003 15:02:47 -0500
Message-ID: <3E7A20EC.1040301@zytor.com>
Date: Thu, 20 Mar 2003 12:13:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Ryan Finnie <rfinnie@redundant.com>
CC: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel.org mirrors] Deprecating .gz format on kernel.org
References: <3E78D0DE.307@zytor.com> <1048185272.1405.12.camel@dhcp-188.dc.rno.redundant.lan>
In-Reply-To: <1048185272.1405.12.camel@dhcp-188.dc.rno.redundant.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Finnie wrote:
> 
> When I started mirroring kernel.org, I was under the assumption that
> most of the world was still using .gz for the most part, and we are
> under a space constraint that prevents us from having both formats (this
> will change once we get the new server for OSS mirrors up and running). 
> However, Matt's stats are pretty interesting.  So even though we
> probably won't be depricating .gz right now, I've switched over my
> mirror from .gz to .bz2.  Peter, mark me (RN-RNO) down as converted.
> 
> Now, if only GNU tar would read .gz OR .bz2 format when specifying -z
> (my fingers automatically type "tar zxvf", and it will take a long time
> to change that.  What is bz2?  j?  That's too hard to remember.)
 >

Yes, for decode it should be able to spawn the right program by looking 
at the magic number.  For encode, well, of course it needs to know.  But 
yes, it's "j".

	-hpa

