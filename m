Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWGLUOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWGLUOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGLUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:14:04 -0400
Received: from smtp-out.google.com ([216.239.33.17]:20219 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750984AbWGLUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:14:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=mpCgYdQwJVhQVGhsuURg/jong6FcM/uExEIxKZw4itn0QowY7dsfklL8MkG586DGW
	m0lheObb+QnHwcXtvGA/A==
Message-ID: <44B557DA.2050208@google.com>
Date: Wed, 12 Jul 2006 13:13:14 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com> <200607121912.52785.dada1@cosmosbay.com>
In-Reply-To: <200607121912.52785.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
> 
>>http://test.kernel.org/abat/40891/debug/test.log.1
>>
>>Filesystem type for /mnt/tmp is xfs
>>write failed on handle 13786
>>4 clients started
>>Child failed with status 1
>>write failed on handle 13786
>>write failed on handle 13786
>>write failed on handle 13786
>>
>>Works fine in -git4
>>All other fs's seemed to run OK.
>>
>>Machine is a 4x Opteron.
> 
> 
> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf

Still fails (thanks Andy).

M.
