Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143435AbRELAgd>; Fri, 11 May 2001 20:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143433AbRELAgZ>; Fri, 11 May 2001 20:36:25 -0400
Received: from steve.prima.de ([62.72.84.2]:26896 "EHLO steve.prima.de")
	by vger.kernel.org with ESMTP id <S143435AbRELAgF> convert rfc822-to-8bit;
	Fri, 11 May 2001 20:36:05 -0400
Message-ID: <XFMail.010512023630.ingo@plato.prima.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <E14yNAQ-0001sM-00@the-village.bc.nu>
Date: Sat, 12 May 2001 02:36:30 +0200 (CEST)
Organization: Private Site
From: Ingo Renner <ingo@plato.prima.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OOPS on 2.4.4-ac4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-May-01 Alan Cox wrote:
>> computer during this time.=20
>> So I don't know if this has to do with the new networkcard, the new NVIDIA
>> Driver 0.9-769 I installed yesterday with XFree 4.3 or something else. The =
> 
>> -----------
>> Module                  Size  Used by
>> via82cxxx_audio        16800   2  (autoclean)
>> soundcore               3600   2  (autoclean) [via82cxxx_audio]
>> ac97_codec              8560   0  (autoclean) [via82cxxx_audio]
>> NVdriver              626480  12  (autoclean)
>> vmnet                  16224   3
>> vmmon                  18224   0
>> dmfe                    9408   1  (autoclean)
> 
> You are using binary only drivers. We can't debug them (least of all a 625K
> module thats almost the size of the kernel).  Duplicate the problems on a
> boot
> that never loaded vmware or nvdriver and its interesting, otherwise take it
> up with vmware and nvidia - they have our source we dont have theirs

Ok, I will remove vmware and switch from the nvidia driver the nv driver from
XFree 4.3. Maybe I get the oops again.

        Ciao,
                Ingo

"The war has already begun, Captain. All that remains now is honor
    and death." 
        -- Deeron, "Points of Departure"

