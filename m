Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWC2A0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWC2A0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWC2A0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:26:54 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:54704 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S964880AbWC2A0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:26:54 -0500
Message-ID: <4429E050.7080008@soleranetworks.com>
Date: Tue, 28 Mar 2006 18:18:08 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org> <4429D3E4.3060305@wolfmountaingroup.com> <4429D11F.6040000@garzik.org>
In-Reply-To: <4429D11F.6040000@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Jeff V. Merkey wrote:
>
>> the detection of and translation of
>> LABEL=/ is passed in the kernel, so its a kernel issue.
>
>
> Incorrect.  The kernel does zero 'LABEL=' processing.  Read 
> init/do_mount*.c.
>
> LABEL= is handled in initrd/initramfs normally.
>
>     Jeff
>
>
>

Jeff,

Thanks for verifying it is passed through the kernel to initrd, another 
kernel component.    It's also stored as EXT meta data
(also in the kernel).  and retrieved from there.  And its not accessible 
from normal user space applications (except in raw mode).
One of these days you need to get down to Lindon for lunch.  I'll even buy.

Jeff
