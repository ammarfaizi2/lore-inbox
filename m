Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWC2Bnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWC2Bnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWC2Bnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:43:33 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:59824 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1750761AbWC2Bnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:43:33 -0500
Message-ID: <4429F247.90209@soleranetworks.com>
Date: Tue, 28 Mar 2006 19:34:47 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org> <4429D3E4.3060305@wolfmountaingroup.com> <4429D11F.6040000@garzik.org> <4429E050.7080008@soleranetworks.com> <20060329014048.GA29971@thunk.org>
In-Reply-To: <20060329014048.GA29971@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Tue, Mar 28, 2006 at 06:18:08PM -0700, Jeff V. Merkey wrote:
>  
>
>>Thanks for verifying it is passed through the kernel to initrd, another 
>>kernel component.    It's also stored as EXT meta data
>>(also in the kernel).  and retrieved from there.  And its not accessible 
>>from normal user space applications (except in raw mode).
>>    
>>
>
>No, the contents of initrd/initramfs is not shipped as part of a
>standard kernel.org kernel.  It is the responsibility of each
>distribution to set up their initrd or initramfs initial boot scripts
>themselves.  One could argue that it would be better if there were a
>standard set of initrd scripts (and udev binaries) paired with
>specific kernel.org kernels and used by all distro's, but that's not
>where we are right now.
>
>  
>
????????

>The data is most certainly accessible from normal userspace
>applications.  All they have to do is link against blkid library; 
>  
>
All you need is a degree from MIT in advanced Fusion mechanics. :-)

>indeed the kernel doesn't do any LABEL= or UUID= searching at all.  By
>design, it all supposed to be done in userspace.
>  
>
?????????

Ted,

I give up on this one. I also agree a standardized initrd with built in 
init is a great idea.

:-)

Jeff

>						- Ted
>
>  
>

