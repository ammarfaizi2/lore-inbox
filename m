Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSHKUQD>; Sun, 11 Aug 2002 16:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318350AbSHKUQD>; Sun, 11 Aug 2002 16:16:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:52752 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318349AbSHKUQC>; Sun, 11 Aug 2002 16:16:02 -0400
Message-ID: <3D56C6A4.5010604@namesys.com>
Date: Mon, 12 Aug 2002 00:18:44 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Christoph Hellwig <hch@infradead.org>,
       Hans Reiser <reiser@bitshadow.namesys.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
References: <200208091636.g79GadA9007889@bitshadow.namesys.com> 	<20020809183850.A17407@infradead.org> <1029097261.16421.45.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Fri, 2002-08-09 at 18:38, Christoph Hellwig wrote:
>  
>
>>Are you sure you want to have a new block allocator in the stable series
>>before it has been added to 2.5?
>>    
>>
>
>Thats what I was also wondering. It seems like its an experimental
>update rather than a bug fix so ought to be 2.5 stuff
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
The non-default mount options are experimental, and the options to have 
things revert to old behaviour play it safe just in case.

I understand why all of you are doubtful about it going into 2.4, it is 
not that you are crazy, but my closeness to the code makes me think it 
is stable enough that it should go in.  Also remember that we have an 
extensive test suite, we have been benchmarking variations on this code 
for months, and I frankly don't think that 2.5 insertion will get it 
enough testing to be instructive to us.

-- 
Hans



