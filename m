Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSEOB3O>; Tue, 14 May 2002 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316198AbSEOB3N>; Tue, 14 May 2002 21:29:13 -0400
Received: from mgw-dax1.ext.nokia.com ([63.78.179.216]:28621 "EHLO
	mgw-dax1.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S316194AbSEOB3M> convert rfc822-to-8bit; Tue, 14 May 2002 21:29:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Tue, 14 May 2002 18:29:11 -0700
Message-ID: <4D7B558499107545BB45044C63822DDE3A206F@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: InfiniBand BOF @ LSM - topics of interest
Thread-Index: AcH7oHVyjR3e/xhQRlmEXwctPk8RMwACg8Lg
From: <Tony.P.Lee@nokia.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <lmb@suse.de>, <woody@co.intel.com>, <linux-kernel@vger.kernel.org>,
        <zaitcev@redhat.com>
X-OriginalArrivalTime: 15 May 2002 01:29:11.0891 (UTC) FILETIME=[EAB8C230:01C1FBAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thats an assumption that is actually historically not a very 
> good one to
> make. There are fundamental things that most of the "no network layer"
> people tend to forget
> 
> 1.	Van Jacobson saturated 10Mbit ethernet with a Sun 3/50
> 2.	SGI saturated HIPPI with MIPS processors that are at 
> best comparable
> 	to the lowest end wince PDAs
> 3.	Having no network layer in almost every case is tied to 
> the belief
> 	that bandwidth is infinite and you need to congestion control
> 
> In a network congestion based collapse is spectacularly bad. 
> Some of the
> internet old hands can probably tell you the horror stories 
> of the period
> the whole internet backbone basically did that until they got 
> their research
> right. Nagle's tinygram congestion avoidance work took Ford's 
> network usage
> down by I believe the paper quoted 90%.
> 
> The socket API is very efficient. TCP is extremely efficient 
> in the service
> it provides. IB can support large messages, which massively 
> ups the throughput.
> 
> Let me ask you a much more important question 
> 
> Can you send achieve 90% efficiency on a 90% utilized fabric 
> with multiple
> nodes and multiple hops ? If you can't then you are not 
> talking about a 
> network you are talking about a benchmark.
> 

Good points,  I prefer to see IB as replacement for
SCSI, FibreChannel, IDE, with its RDMA, messaging and
reliable connection, user mode DMA type features.   They
are type of connections without the congestion avoidance
issues associate with TCP design - the "no network layer"
type of works.


I don't know if IB over multi-nodes/multi-hops in a WAN like
setup works or not.  I like to see network experts like 
yourself try to break that since all the congestion control which
is "supposely" done in HW as compare to doing that in software as 
in TCP/IP.  It would be nice to know how solid is the overall 
IB congestion control design in that environment and at 
what point does it break.   


IP over IB is a bit like IP over SCSI or IP over FibreChannel
for me.





