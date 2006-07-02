Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWGBUrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWGBUrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWGBUrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 16:47:20 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:52617 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750759AbWGBUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 16:47:19 -0400
To: Andy Gay <andy@andynet.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO transfers
X-Message-Flag: Warning: May contain useful information
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com>
	<1151872141.3285.486.camel@tahini.andynet.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 02 Jul 2006 13:47:13 -0700
In-Reply-To: <1151872141.3285.486.camel@tahini.andynet.net> (Andy Gay's message of "Sun, 02 Jul 2006 16:29:01 -0400")
Message-ID: <adazmfrbupa.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Jul 2006 20:47:17.0794 (UTC) FILETIME=[B4E4E020:01C69E18]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I don't know which of these devices present multiple EPs though. Can you
 > send me the appropriate section from 'cat /proc/bus/usb/devices'?

Sure, no problem:

T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0c88 ProdID=17da Rev= 0.00
S:  Manufacturer=Qualcomm, Incorporated
S:  Product=Qualcomm CDMA Technologies MSM
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=airprime
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=airprime
E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
