Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSJVUDC>; Tue, 22 Oct 2002 16:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSJVUDC>; Tue, 22 Oct 2002 16:03:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62138 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264919AbSJVUDB>; Tue, 22 Oct 2002 16:03:01 -0400
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <408130000.1035313435@flay>
References: <2629464880.1035240956@[10.10.2.3]>
	<Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
	<20021022131930.A20957@redhat.com> <396790000.1035308200@flay>
	<20021022134501.C20957@redhat.com> <3DB59134.38AA41F6@digeo.com>
	<20021022140155.E20957@redhat.com>  <408130000.1035313435@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:23:59 +0100
Message-Id: <1035318239.329.141.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 20:03, Martin J. Bligh wrote:

> > Can we delete the specialty syscalls now?
> 
> I was lead to believe that Linus designed them, so he may be emotionally attatched 
> to them, but I think there would be few others that would cry over the loss ...

You mean like the wonderfully pointless sys_readahead. The sooner these
calls go the better.

