Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWIBS31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWIBS31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWIBS31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:29:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:7876 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751019AbWIBS30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:29:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] mcs7830: fix reception of 1514 byte frames
Date: Sat, 2 Sep 2006 20:29:00 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net,
       David Hollis <dhollis@davehollis.com>, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608272241.54161.arnd@arndb.de> <200609020333.02285.david-b@pacbell.net>
In-Reply-To: <200609020333.02285.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609022029.01385.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 September 2006 12:33, David Brownell wrote:
> Shouldn't you add VLAN_HLEN too, in case 802.1q is in use?
> 
> I'm not entirely sure how that's expected to work myself...
> 
I don't know if I can expect that device to even do VLAN frames
correctly, the specs don't mention it at all.

There is however a mention of 'large frame whose length is >1518 Bytes',
so it might be good to allow larger frames anyway, though I can't find
any information about what maximum size is supported.

	Arnd <><

-- 
VGER BF report: U 0.5
