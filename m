Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319272AbSIEW57>; Thu, 5 Sep 2002 18:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319273AbSIEW57>; Thu, 5 Sep 2002 18:57:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47753 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319272AbSIEW56>; Thu, 5 Sep 2002 18:57:58 -0400
Message-ID: <3D77E24C.8020808@us.ibm.com>
Date: Thu, 05 Sep 2002 16:01:32 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: Troy Wilson <tcw@tempest.prismnet.com>, jamal <hadi@cyberus.ca>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <200209052211.g85MBFdm099387@tempest.prismnet.com> <1031265571.3d77dd23caec4@imap.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:
> SpecWeb99 doesnt execute the path that might benefit the 
> most from this patch - sendmsg() of large files - large writes
> going down..

For those of you who don't know Specweb well, the average size of a request 
is about 14.5 kB.  The largest files are ~5mb, but the largest top out at 
just under a meg.

-- 
Dave Hansen
haveblue@us.ibm.com

