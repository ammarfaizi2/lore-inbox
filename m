Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVKPNej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVKPNej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVKPNej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:34:39 -0500
Received: from barclay.balt.net ([195.14.162.78]:28485 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S1030321AbVKPNej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:34:39 -0500
Date: Wed, 16 Nov 2005 15:33:10 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116133310.GE31362@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com> <20051116094551.GA23140@gemtek.lt> <20051116114052.GA14042@gemtek.lt> <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI> <20051116131505.GD31362@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116131505.GD31362@gemtek.lt>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka, 

I was too quick to announce success :( ... 20min. later laptop froze
again. I forgot to do sysrq-T :( and there was no oops or any slab
corruption messages in /var/log/kernel ... :|

Back to the problem ... It might not be a full fix for a problem, it
takes much longer to reproduce ... :\

Zilvinas

On Wed, Nov 16, 2005 at 03:15:05PM +0200, Zilvinas Valinskas wrote:
> Hello Pekka,
> 
> this time a very good news, it seems your patch has helped ! For now I
> am running 2.6.15-rc1 just fine. I wasn't able to trigger the problem
> with wpa_supplicant (0.4.6). Don't see any f/w restarts or freezing. 
> Only usual msgs (harmless messages ?):
> 
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
> 
> For now I am booting from single user mode to a multi user mode and
> allow wpa_supplicant to do it's work. Lets wait and see.
> 
> Also this time I saw f/w loading problem and as a result, oops:
> http://www.gemtek.lt/~zilvinas/dumps/trace.4. 
> 
> F/W load has failed as a result followed oops in yenta driver +
> slabcorruption ... Rebooted several times, no f/w loading problems and
> now I am running 2.6.15-rc1 in runlevel 2 (X started & services ...).
> Lets wait and see what will happen next :) ...
> 
> Good work Pekka !
> 
> Zilvinas Valinskas
