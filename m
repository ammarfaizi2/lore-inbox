Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWBZWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWBZWik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWBZWij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:38:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:51627 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751413AbWBZWii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:38:38 -0500
X-Authenticated: #31060655
Message-ID: <44022DEC.1070601@gmx.net>
Date: Sun, 26 Feb 2006 23:38:36 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: pomac@vapor.com
CC: Arjan van de Ven <arjan@infradead.org>, woho@woho.de,
       Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
References: <4400FC28.1060705@gmx.net>	 <20060225180353.5908c955@localhost.localdomain>	 <200602260957.04305.woho@woho.de>  <1140966011.22812.2.camel@localhost>	 <1140968831.2934.32.camel@laptopd505.fenrus.org> <1140970427.23375.11.camel@localhost>
In-Reply-To: <1140970427.23375.11.camel@localhost>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien schrieb:
> On Sun, 2006-02-26 at 16:47 +0100, Arjan van de Ven wrote:
> 
>>On Sun, 2006-02-26 at 16:00 +0100, Ian Kumlien wrote:
>>
>>>On Sun, 2006-02-26 at 09:57 +0100, Wolfgang Hoffmann wrote:
>>>
>>>>On Sunday 26 February 2006 03:03, Stephen Hemminger wrote:
>>>>
>>>>>Instead of whining, try this.
>>>>
>>>>I tried and still see the hang.
>>>
>>>I'm at a record 12 hours with that patch.
>>
>>shhh don't jinx it ;)
> 
> 
> Well it died 33 mins later... =)
> 
> I also saw some oddities... portage stopped working, i dunno if this can
> be MSI related or so, else something is trashing memory in a very
> special way =P

Yes, 0.15 causes memory corruption even if MSI is disabled.


Regards,
Carl-Daniel
