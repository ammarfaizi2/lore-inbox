Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283594AbRLDXig>; Tue, 4 Dec 2001 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRLDXiR>; Tue, 4 Dec 2001 18:38:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40687 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283016AbRLDXiH>; Tue, 4 Dec 2001 18:38:07 -0500
Date: Tue, 04 Dec 2001 15:37:37 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Lars Brinkhoff <lars.spam@nocrew.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Larry McVoy <lm@bitmover.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2457910296.1007480257@mbligh.des.sequent.com>
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Premise 3: it is far easier to take a bunch of operating system images
>> >    and make them share the parts they need to share (i.e., the page
>> >    cache), than to take a single image and pry it apart so that it
>> >    runs well on N processors.
>> 
>> Of course it's easier. But it seems like you're left with much more
>> work to reiterate in each application you write to run on this thing.
>> Do you want to do the work once in the kernel, or repeatedly in each
>> application?
> 
> There seems to be a little misunderstanding here; from what
> I gathered when talking to Larry, the idea behind ccClusters
> is that they provide a single system image in a NUMA box, but
> with separated operating system kernels.

OK, then I've partially misunderstood this ... can people provide some 
more reference material? Please email to me, and I'll collate the results
back to the list (should save some traffic).

I have already the following:

http://www.bitmover.com/talks/cliq/slide01.html 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0001.2/1172.html 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0001.3/0236.html 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0007.3/1222.html 

Thanks,

Martin.

