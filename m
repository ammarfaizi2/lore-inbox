Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316027AbSENUTU>; Tue, 14 May 2002 16:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316033AbSENUTT>; Tue, 14 May 2002 16:19:19 -0400
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:60135 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S316027AbSENUTS> convert rfc822-to-8bit; Tue, 14 May 2002 16:19:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Tue, 14 May 2002 13:19:13 -0700
Message-ID: <4D7B558499107545BB45044C63822DDE3A206D@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: InfiniBand BOF @ LSM - topics of interest
Thread-Index: AcH62pqE0IDRVhO6R0mP3oMsmfZcuwApvd6g
From: <Tony.P.Lee@nokia.com>
To: <alan@lxorguk.ukuu.org.uk>, <lmb@suse.de>
Cc: <woody@co.intel.com>, <linux-kernel@vger.kernel.org>, <zaitcev@redhat.com>
X-OriginalArrivalTime: 14 May 2002 20:19:14.0317 (UTC) FILETIME=[9DB42BD0:01C1FB84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > On 2002-05-14T00:42:07,
> >    Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> > 
> > > Kernel mode RPC over infiniband - relevant to mosix type 
> stuff, to McVoy
> > > scalable cluster type stuff and also to things like file 
> system offload
> > 
> > For that, a generic comm interface would be a good thing to 
> have first.
> 
> It has to be fast, nonblocking and kernel callable. Cluster 
> people count
> individual microseconds so its base layers must be extremely efficient
> even if there are "easy use" layers above. The obvious "easy 
> use" layer being
> IP over infiniband.
> 

I like to see user application such as VNC, SAMBA build directly
on top of IB API.  I have couple of IB cards that can 
send 10k 32KBytes message (320MB of data) every ~1 second over 
1x link with only <7% CPU usage (single CPU xeon 700MHz).  
I was very impressed.  

Go thru the socket layer API would just slow thing down.

With IB bandwidth faster than standard 32/33MHZ PCI, one might
run DOOM over VNC over IB on remote computer faster 
than a normal PC running DOOM locally....

One might create a OS that miror the complete process state
info (replicate all the modified page) everytime that 
process is schedule out. 


----------------------------------------------------------------
Tony Lee         
