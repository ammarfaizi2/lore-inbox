Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315249AbSDWPrB>; Tue, 23 Apr 2002 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315250AbSDWPrA>; Tue, 23 Apr 2002 11:47:00 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:24850 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315249AbSDWPrA>; Tue, 23 Apr 2002 11:47:00 -0400
Message-ID: <3CC581F6.6050103@loewe-komp.de>
Date: Tue, 23 Apr 2002 17:47:02 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
CC: kernel@Expansa.sns.it,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC56355.E5086E46@TeraPort.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
>>Re: XFS in the main kernel
>>
>>From: Luigi Genoni (kernel@Expansa.sns.it)
>>On Tue, 23 Apr 2002, Keith Owens wrote:
>>
>>
>>>On 22 Apr 2002 18:55:20 +0200,
>>>wichert@cistron.nl (Wichert Akkerman) wrote:
>>>
>>>>In article <3CC427F4.12C40426@fnal.gov>,
>>>>Dan Yocum <yocum@fnal.gov> wrote:
>>>>
>>>>>I know it's been discussed to death, but I am making a formal request to you
>>>>>to include XFS in the main kernel. We (The Sloan Digital Sky Survey) and
>>>>>many, many other groups here at Fermilab would be very happy to have this in
>>>>>the main tree.
>>>>>
>>>>Has XFS been proven to be completely stable
>>>>
>>>As much as any other filesystem. "There are no bugs in filesystem XYZ.
>>>That just means that you have not looked hard enough." :) There is a
>>>daily QA suite that XFS is run through.
>>>
>>In the reality the inclusion on XFS in the 2.5 tree would probably move
>>more peole to use it, and so also to eventually trigger bugs, to report
>>them, sometimes to fix them.
>>This way XFS would improve faster, and of course that would be a
>>good thing.
>>
>>
> 
>  definitely. Unless XFS is in the mainline kernel (marked as
> experimantal if necessary) it will not get good exposure.
> 
>  The most important (only) reason I do not use it (and recommend our
> customers against using it) is that at the moment it is impossible to
> track both the kernel and XFS at the same time. This is a shame, because
> I think that for some application XFS is superior to the other
> alternatives (can be said about the other alternatives to :-).
>  
> 
>>That said, it is important to
>>consider the technical reasons to include XFS in 2.5 or not; if this
>>inclusion could cause some troubles, if XFS fits the requirements
>>Linus asks for the inclusion and what impact the inclusion would have on
>>the kernel (Think to JFS as a good example of an easy inclusion, with low
>>impact).
>>
>>
> 
>  so, what were the main obstacles again? The VFS layer?
> 

The VFS and such features like "delayed block allocation". XFS tries
to gather 64K or so before submitting to disk/block layer.

FWIW, SuSE 8 ships with full (but experimental marked) XFS support.



