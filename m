Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263567AbREYGLS>; Fri, 25 May 2001 02:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263568AbREYGLI>; Fri, 25 May 2001 02:11:08 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:1974 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263567AbREYGKx>; Fri, 25 May 2001 02:10:53 -0400
Message-Id: <200105250610.f4P6AhH09533@smtp2.Stanford.EDU>
From: Praveen Srinivasan <praveens@stanford.edu>
Subject: Re: [PATCH] bulkmem.c - null ptr fixes for 2.4.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: praveens@stanford.edu
Date: Thu, 24 May 2001 23:12:00 -0700
In-Reply-To: <fa.gocl8kv.gohl@ifi.uio.no> <fa.ggh8rmv.6h4jao@ifi.uio.no>
Organization: Stanford University
User-Agent: KNode/0.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we need to free the linked list in setup_regions? Would it be easier to 
try and preallocate the structures beforehand, and then fill them with the 
loop? Btw, we didn't find anything wrong with the first part of the patch.

Praveen Srinivasan and Frederick Akalin

Alan Cox wrote:

>> kernel code. This patch fixes numerous unchecked pointers in the PCMCIA
>> bulkmem driver.
> 
> Since when has two been numerous - also I dont thin the fix is right - you
> need to undo what has already been done
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

