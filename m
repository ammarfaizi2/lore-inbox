Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJJSx5>; Thu, 10 Oct 2002 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbSJJSx5>; Thu, 10 Oct 2002 14:53:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31179 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262137AbSJJSx4>;
	Thu, 10 Oct 2002 14:53:56 -0400
Message-ID: <3DA5CD19.80603@us.ibm.com>
Date: Thu, 10 Oct 2002 11:55:21 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <1034240403.1745.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2002-10-10 at 03:12, Matthew Dobson wrote:
> 
>>Greetings & Salutations,
>>	Here's a wonderful patch that I know you're all dying for...  Memory 
>>Binding!  It works just like CPU Affinity (binding) except that it binds 
>>a processes memory allocations (just buddy allocator for now) to 
>>specific memory blocks.
> 
> If the VM works right just doing CPU binding ought to be enough, surely?
You'll have to look at the response I wrote to Andrew's question along 
the same
lines...  This patch is for processes who feel that the VM *isn't* doing
quite what they want, and want different behavior.

Cheers!

-Matt

