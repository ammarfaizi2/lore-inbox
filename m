Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWGMJE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWGMJE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWGMJE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:04:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:44162 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964857AbWGMJE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:04:56 -0400
Message-ID: <44B60CB3.4000806@fr.ibm.com>
Date: Thu, 13 Jul 2006 11:04:51 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Michael Holzheu <HOLZHEU@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
References: <44B5C7CE.6090606@us.ibm.com> <44B5C971.7030403@us.ibm.com>
In-Reply-To: <44B5C971.7030403@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Badari Pulavarty wrote:
>> Hi Micheal,
>>
>> I made fixes to hypfs to fit new vfs ops interfaces. I am not sure if
>> we really
>> need to vectorize aio interfaces, can you check and see if this is okay ?
>>
>> And also, I am not sure what hypfs_aio_write() is actually doing.
>> It doesn't seem to be  doing with "buf" ?
>>
>> (BTW - I have no way to verify these change. Can you give them a spin ?)
>>
>> Thanks,
>> Badari
> 
> Here is the updated version ..

indeed it compiles better :)

it boots fine. what kind of tests do you run ?

thanks,

C.
