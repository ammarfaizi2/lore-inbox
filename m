Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSH0PwB>; Tue, 27 Aug 2002 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSH0PwB>; Tue, 27 Aug 2002 11:52:01 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:50164 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S316446AbSH0PwA>;
	Tue, 27 Aug 2002 11:52:00 -0400
Date: Tue, 27 Aug 2002 11:49:29 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Mala Anand <manand@us.ibm.com>
cc: Bill Hartner <bhartner@us.ibm.com>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
In-Reply-To: <OFC842923C.BD15E014-ON87256C22.0047BBD6@boulder.ibm.com>
Message-ID: <Pine.GSO.4.30.0208271147320.10164-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Aug 2002, Mala Anand wrote:

> SPECweb99 profile shows that __kfree_skb is in the top 5 hot routines. We
> will test the skb recycle patch on SPECweb99 and add skbinit patch
> to that and see how it helps.  What I understand is that the skb recycle
> patch does not attempt to recycle if the skbs are allocated on CPU
> and freed on another CPU. Is that right? If so, skbinit patch will help
> those cases.

yes it will. Not significant is my current thinking. i.e i wouldnt write
my mother to tell her about it.

cheers,
jamal

