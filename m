Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUEZJsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUEZJsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUEZJsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:48:15 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:3248 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265386AbUEZJsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:48:13 -0400
Message-ID: <40B467DA.4070600@yahoo.com.au>
Date: Wed, 26 May 2004 19:48:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Buddy Lumpkin <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> 
>>Even for systems that don't *need* the extra memory space, swap can
>>actually provide performance improvements by allowing unused memory
>>to be replaced with often-used memory.
> 
> 
> That's true, but it's not a magical property of swap space - extra physical
> RAM would do more or less the same thing.
> 

Well it is a magical property of swap space, because extra RAM
doesn't allow you to replace unused memory with often used memory.

The theory holds true no matter how much RAM you have. Swap can
improve performance. It can be trivially demonstrated.
