Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWJDSCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWJDSCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161940AbWJDSCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:02:11 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:42400 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161930AbWJDSCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:02:06 -0400
Message-ID: <4523F75A.7040504@candelatech.com>
Date: Wed, 04 Oct 2006 11:03:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com> <m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com> <m3hcyo2qvs.fsf@defiant.localdomain> <45200BD7.6030509@candelatech.com> <1159735586.13029.180.camel@localhost.localdomain> <4523384E.7060806@candelatech.com> <20061004142047.GA30993@csclub.uwaterloo.ca>
In-Reply-To: <20061004142047.GA30993@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Tue, Oct 03, 2006 at 09:27:58PM -0700, Ben Greear wrote:
>   
>> I think you might be right.  It will take some more experimenting to see 
>> if they allow
>> enough control to read/write bitstreams (clear channel groups in their 
>> terminology, I believe) while at
>> the same time keeping the timing slots in order...
>>     
>
> Sangoma also makes cards with linux drivers, which I suspect will let
> you at the low levels if you want to.  They certainly support zaptel
> stuff on their cards.  Their hardware is also quite a bit cheaper than
> farsite's in my experience.
>   
Sangoma's NICs used to work for me..but it seems their latest drivers 
broke the
support that I need.  I think there aren't too many people interested in 
bit-streaming, so
the feature probably doesn't get tested that often...  If I can get the 
digium hardware to
work with a particular zaptel.conf, then I can try Sangoma and see if it 
will work when
configured in that same manner...

Thanks,
Ben

> --
> Len Sorensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


