Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTAHWxA>; Wed, 8 Jan 2003 17:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267958AbTAHWxA>; Wed, 8 Jan 2003 17:53:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:244 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267954AbTAHWw6>;
	Wed, 8 Jan 2003 17:52:58 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C0AD0F269@orsmsx108.jf.intel.com>
From: "Ronciak, John" <john.ronciak@intel.com>
To: "'Robert Olsson'" <Robert.Olsson@data.slu.se>,
       Avery Fay <avery_fay@symantec.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: RE: Gigabit/SMP performance problem
Date: Wed, 8 Jan 2003 13:44:05 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

We (Intel - LAN Access Division, e1000 driver) are taking a look at what is
going on here.  We don't have any data yet but we'll keep you posted on what
we find.

Thanks for your patients.

Cheers,
John



> -----Original Message-----
> From: Robert Olsson [mailto:Robert.Olsson@data.slu.se]
> Sent: Tuesday, January 07, 2003 10:16 AM
> To: Avery Fay
> Cc: Anton Blanchard; linux-kernel@vger.kernel.org
> Subject: Re: Gigabit/SMP performance problem
> 
> 
> 
> Avery Fay writes:
>  > Hmm. That paper is actually very interesting. I'm thinking 
> maybe with the 
>  > P4 I'm better off with only 1 cpu. WRT hyperthreading, I 
> actually disabled > it because it make performance worse 
> (wasn't clear in the original email).
> 
> 
>  With 1CPU-SMP-HT I'm on UP level of performance this with 
> forwarding two 
>  single flows evenly distributes between CPU's. So HT payed 
> the SMP cost so 
>  to say.
>  
>  Also I tested the MB bandwidth with new threaded version of 
> pktgen just 
>  TX'ing a packets on 6 GIGE I'm seeing almost 6 Gbit/s TX'ed 
> w 1500 bytes
>  packets.
> 
>  I have problem populating all slots w. GIGE NIC's. WoL (Wake 
> on Lan) this
>  is a real pain... Seems like my adapters needs a standby 
> current 0.8A and 
>  most Power Supplies gives 2.0A for this. (Number come from 
> SuperMicro). 
>  So booting fails radomlingy. You have 8 NIC's -- Didn't you 
> have problem?
> 
>  Anyway I'll guess profiling is needed?
> 
>  Cheers.
> 						--ro
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
