Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFMVv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFMVv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVFMVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:50:11 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:30578 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261472AbVFMVsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:48:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Voluspa <lista1@telia.com>
Subject: Re: mouse still losing sync and thus jumping around
Date: Mon, 13 Jun 2005 16:47:53 -0500
User-Agent: KMail/1.8.1
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
References: <20050613234039.7d3ed895.lista1@telia.com>
In-Reply-To: <20050613234039.7d3ed895.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131647.53603.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:40, Voluspa wrote:
> 
> On 2005-02-23 16:53:04 Dmitry Torokhov wrote:
> > On Wed, 23 Feb 2005 17:29:49 +0100, Nils Kalchhauser wrote:
> [...]
> >> it seems to me like it is connected to disk activity... is that
> >> possible?
> 
> > Yes, It usually happens either under high load, when mouse interrupts
> > are significantly delayed. Or sometimes it happen when applications
> > poll battey status and on some boxes it takes pretty long time. And
> > because it is usually the same chip that serves keyboard/mouse it
> > again delays mouse interrupts.
> 
> My notebook is an Acer Aspire 1520 (1524) with a Synaptics Touchpad,
> model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
> 
> Kernels 2.6.11.11 and 2.6.12-rc6
> Synaptics driver 0.14.2
> 
> The "lost sync at byte" and "driver resynched" began flooding the logs
> when I enabled Sensors --> Temperatures --> thermal_zone [THRC/THRS] in
> the system monitor gkrellm. I haven't tried battery monitoring.
> 
> There are only occasional mouse pointer jumps, but the logfiles grow
> very quickly. I tried reducing the gkrellm updates from 10 times a
> second to 2, but it only had a marginal effect. It seems a bit silly
> that this powerful notebook (AMD64 Athlon 3400+) can't 'multitask'
> correctly.
> 

Try setting frequency to once a minute, that should help.

-- 
Dmitry
