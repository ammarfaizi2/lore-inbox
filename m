Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292560AbSB0Pcg>; Wed, 27 Feb 2002 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSB0Pc1>; Wed, 27 Feb 2002 10:32:27 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:12496 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292579AbSB0PcS>; Wed, 27 Feb 2002 10:32:18 -0500
Date: Wed, 27 Feb 2002 07:03:50 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: m.knoblauch@TeraPort.de, Martin.Bligh@us.ibm.com
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in
 thetree
Message-ID: <311985531.1014793429@[10.10.2.3]>
In-Reply-To: <3C7CB28A.CAD095B5@TeraPort.de>
In-Reply-To: <3C7CB28A.CAD095B5@TeraPort.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> rmap still sucks on large systems though. I'd love to see rmap
>> in the main kernel, but it needs to get the scalability fixed first.
>> The main problem seems to be pagemap_lru_lock ... Rik & crew
>> know about this problem, but let's give them some time to fix it
>> before rmap gets put into mainline ....
>
>  just out of curiosity: where does "large systems" start in your
> context?

I think the last tests I was doing was on a 12cpu box, which
gave me about a 40% performance degredation by installing rmap.
Most people won't be interested in anything near that large,
but as Rik said, the problems will start on much smaller systems.
One of the nice things about running really large systems is
that they show up scalability problems and race conditions
really quickly and obviously ;-)

If someone has data for 4 or 8 way systems, I'd love to see it.
Else I'll get some myself in a little while.

Thanks,

Martin.

