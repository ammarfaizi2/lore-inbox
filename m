Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277047AbRJHSBV>; Mon, 8 Oct 2001 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277044AbRJHSBA>; Mon, 8 Oct 2001 14:01:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31666 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277054AbRJHSAs>; Mon, 8 Oct 2001 14:00:48 -0400
Date: Mon, 08 Oct 2001 10:57:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, landley@trommello.org
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
Message-ID: <1811287155.1002538667@mbligh.des.sequent.com>
In-Reply-To: <E15pWKG-0006aj-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So would a workable (if naieve) attempt to use Andrea's 
>> memory-zones-grouped-into-classes approach on NUMA just involve making a 
>> class/zone list for each node?  (Okay, you've got to identify nodes, and 
>> group together processors, bridges, DMAable devices, etc, but it seems like 
>> that has to be done anyway, class/zone or not.)  How does what people want to 
>> do for NUMA improve on that?
> 
> I fear it becomes an N! problem.
> 
> I'd like to hear what Andrea has planned since without docs its hard to 
> speculate on how the 2.4.10 vm works anyway

Can you describe why it's N! ? Are you talking about the worst possible case, 
or a two level local / non-local problem?

Thanks,

Martin.

