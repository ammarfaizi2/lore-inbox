Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWGLUZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWGLUZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWGLUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:25:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28631 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751000AbWGLUZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:25:10 -0400
Message-ID: <44B55A9E.2010403@us.ibm.com>
Date: Wed, 12 Jul 2006 13:25:02 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com> <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>
In-Reply-To: <44B557DA.2050208@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Eric Dumazet wrote:
>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
>>
>>> http://test.kernel.org/abat/40891/debug/test.log.1
>>>
>>> Filesystem type for /mnt/tmp is xfs
>>> write failed on handle 13786
>>> 4 clients started
>>> Child failed with status 1
>>> write failed on handle 13786
>>> write failed on handle 13786
>>> write failed on handle 13786
>>>
>>> Works fine in -git4
>>> All other fs's seemed to run OK.
>>>
>>> Machine is a 4x Opteron.
>>
>>
>> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf
>
> Still fails (thanks Andy).
>
Wondering if its my changes :(
Can you back out these and try ?

Please, Please tell me that, its not me :)

Thanks,
Badari

#
vectorize-aio_read-aio_write-fileop-methods.patch
remove-readv-writev-methods-and-use-aio_read-aio_write.patch
streamline-generic_file_-interfaces-and-filemap.patch
streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch



