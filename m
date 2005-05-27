Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVE0Sds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVE0Sds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVE0Sdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:33:47 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:4247 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S262532AbVE0Sdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:33:35 -0400
Date: Fri, 27 May 2005 21:33:28 +0300
From: Ville Herva <vherva@vianova.fi>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4 broke right <win>-key
Message-ID: <20050527183328.GH5470@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050527163549.GV16169@viasys.com> <d120d50005052709467c523abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005052709467c523abc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.vianova.fi 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 11:46:42AM -0500, you [Dmitry Torokhov] wrote:
> On 5/27/05, Ville Herva <vherva@vianova.fi> wrote:
> > After upgrading from 2.6.11-rc1-ck2 to 2.6.12-rc4, the right <win>-key on my
> > HP "multimedia" keyboard (something like http://www.pc-netto.dk/templates/product.asp?productguid=C4742B%23ABY&groupguid=11437)
> > seized to work. The left one still works. The earlier kernels I've run
> > never showed this problem (although the multimedia keys seem to map to
> > different codes in each and every kernel version, which is slightly
> > annoying.) The older kernels I've tried include 2.6.8.1-mm2, 2.6.8.1,
> > 2.6.6-mm4, 2.6.3, and a heap of 2.4 kernels.
> > 
> 
> Hi,
> 
> This patch from Vojtech shoudl get you going:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111712306027138&q=raw

Ahh, thanks. 

I tried to find previous discussion on this issue before posting but
apparently was too negligent.

Also Domen Puncer's suggested workaround
    echo -n "0" > /sys/bus/serio/devices/serio1/scroll
in the same thread seems to work.


-- v -- 

v@iki.fi

