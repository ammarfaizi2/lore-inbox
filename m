Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVCDM2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVCDM2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVCDM14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:27:56 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:12742 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262880AbVCDMWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:22:08 -0500
Date: Fri, 4 Mar 2005 13:24:34 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: gene.heskett@verizon.net, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050304122434.GB9121@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, gene.heskett@verizon.net,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
	Gerd Knorr <kraxel@bytesex.org>
References: <200503032119.04675.gene.heskett@verizon.net> <4227CE34.2040805@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4227CE34.2040805@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.58.112
Subject: Re: [linux-dvb-maintainer] Re: 2.6.11 vs DVB cx88 stuffs
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 06:55:48PM -0800, Randy.Dunlap wrote:
> Gene Heskett wrote:
> >Greetings;
> >
> >I've a new pcHDTV-3000 card, and I thought maybe it would
> >be a good idea to build the cx88 stuff in the DVB section
> >of a make xconfig.
> >
> >It doesn't build, spitting out this bailout:
...
> >Another patch needed maybe?
> 
> Sure, some patch is needed.  Let's ask the maintainer (cc-ed).
> 
> BTW, to get this you had to enable CONFIG_BROKEN:
> 
> config VIDEO_CX88_DVB
>         tristate "DVB Support for cx2388x based TV cards"
>         depends on VIDEO_CX88 && DVB_CORE && BROKEN
>         select VIDEO_BUF_DVB

Gerd Knorr has patches pending which depend on patches which
I have to create from linuxtv.org CVS. I will submit then asap.

Johannes
