Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbRFWFPN>; Sat, 23 Jun 2001 01:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbRFWFPD>; Sat, 23 Jun 2001 01:15:03 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:42762 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265636AbRFWFO7>; Sat, 23 Jun 2001 01:14:59 -0400
Message-Id: <200106230514.f5N5EnU84722@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: stimits@idcomm.com, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 14:54:22 +1000."
             <13170.993272062@ocs3.ocs-net> 
Date: Fri, 22 Jun 2001 23:14:49 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 22 Jun 2001 22:17:12 -0600, 
>"D. Stimits" <stimits@idcomm.com> wrote:
>> On Fri, 22 Jun 2001 13:39:45 -0600,
>>> "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>> Users don't have to manually select "rebuild firmware".  They can
>>> rely on the generated files already in the aic7xxx directory.  This
>>> is why the option defaults to off.
>>
>>For the SGI patched kernels based on either 2.4.5 or 2.4.6-pre1, I have
>>had to manually select this for a 7892 controller. Without manually
>>selecting it, it guarantees boot failure. I don't know if this is due to
>>the SGI modifications or not.
>
>It is a side effect of the SGI source control system.

Can you explain why this would be the case?  Are you saying that SGI
is building the generated file and also keeping it in their revision
control system?  If so, wouldn't their shipped config also include
building the firmware?

I think one of my distributed patches is somehow screwed up and this
error was propogated into the SGI kernel distribution.

--
Justin
