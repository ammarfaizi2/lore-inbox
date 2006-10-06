Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWJFUfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWJFUfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWJFUfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:35:12 -0400
Received: from fw03-net.analyticinnovations.com ([65.206.171.66]:49567 "EHLO
	fw03-net.analyticinnovations.com") by vger.kernel.org with ESMTP
	id S932597AbWJFUfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:35:11 -0400
Message-ID: <4526BE14.5000103@analyticinnovations.com>
Date: Fri, 06 Oct 2006 15:35:32 -0500
From: Eric Kamm <eric@analyticinnovations.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: machine oops under heavy I/O or network access ???
References: <45253993.9070400@analyticinnovations.com>
In-Reply-To: <45253993.9070400@analyticinnovations.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Kamm wrote:
> Hello,
> 
> I apologize for the long post.   I tried to include as much
> relevant information as possible.
> 
> Thank you,
> Eric
> 
> 
> [1.] One line summary of the problem:
> machine oops under heavy I/O or network access ???
> 
> [2.] Full description of the problem/report:
> 
> I have a Supermicro X6DHE-XG2 (Intel E7520 chipset) with dual Xeon with 
> 4GB RAM.
> I am using one 3ware 8005 controller, three 3ware 9550sx controllers, and
> reiserfs.  This machine is acting primarily to serve NFS.
> 
> The oops below are from my original machine configuration, but I have 
> tried other some variations and have other oops:
> 
>     - I have tried Suse 10.1 kernels 2.6.16.13-4-smp and 2.6.16.13-4-default.
>     - I have rebuilt the system onto an identical spare hardware configuration.
>     - I have used 64-bit and 32-bit kernel versions.
>     - I have replaced all the shared reiserfs filesytems with ext3.
> 
> In all cases under load, disk IO alone (NFS server off) or disk IO+NFS 
> operations, the system has oops and "general protection fault" errors.
> 
> The process is usually nfds or rpc.mountd, but (with the NFS server turned off) I
> also have errors from, for example, cp and rsync.  The system has been 
> up for as much as 16 hours with no problems, and sometimes as little as five minutes.
> 
(~1000 lines snipped)

Any help/pointers will be greatly appreciated.

     - Did I post this to an appropriate place?  If not, could you
       recommend a place to report this problem?

     - Is there something else you can suggest I do to further understand
       the problem?

Thank you,
Eric





