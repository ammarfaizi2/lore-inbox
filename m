Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269639AbUIRV2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbUIRV2t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUIRV2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 17:28:49 -0400
Received: from gw.pasop.tomt.net ([80.239.42.1]:55482 "EHLO puppen.tomt.net")
	by vger.kernel.org with ESMTP id S269639AbUIRV2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 17:28:47 -0400
Message-ID: <414CA90F.2060106@tomt.net>
Date: Sat, 18 Sep 2004 23:30:55 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5rten_Berggren?= <berg@enea.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE: pdc202xx_new on Asus A7V333?
References: <000401c49dc5$93e4f3b0$810113ac@enea.se>
In-Reply-To: <000401c49dc5$93e4f3b0$810113ac@enea.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mårten Berggren wrote:
> Hi,
> 
> I have been trying to get pdc202xx_new working (in 2.4.27) on my
> Asus A7V333 motherboard (with VIA KT333 and a PDC20276). Loading
> it as a module with modprobe gives me the following entires in the
> syslog:
<snip>
> which gives me the impression that the module has loaded ok, but there
> is no matching entries in /proc/ide and pdcraid does not find it.
> So is there any way to tell if it is working or not? (Should there
> be an entry in /proc/ide?)

If it's a so-called "raid" version of the PDC, you may need to enable 
CONFIG_PDC202XX_FORCE, as the firmware "hides" the drives.
