Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSE0Qcl>; Mon, 27 May 2002 12:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSE0Qcl>; Mon, 27 May 2002 12:32:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59886 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316679AbSE0Qcj>; Mon, 27 May 2002 12:32:39 -0400
Subject: Re: i8259 and IO-APIC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1022510160.12202.113.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 18:34:37 +0100
Message-Id: <1022520877.11859.298.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 15:35, Terje Eggestad wrote:
> Do you got any numbers that state that it's processing overhead, and not
> HW latency that is the bulk of interrupt service time? Just curious,
> I've been looking and can't find this "perceived fact" backed up by
> facts anywhere. 

It depends what the interrupt actually does. What I was saying is that
the processing overhead is what hurts not the latency. If you think
about a continual stream of events latency on the busses effectively
skews the delivery time of the interrupt but not the rate of processing.

> BTW: according to "IA-32 Intel Arch. Software Developer's Man Vol 3"
> both P3 and P4 the APIC bus is three wire, two data and one clock. 


