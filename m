Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWACRGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWACRGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWACRGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:06:32 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:28304 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751470AbWACRGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:06:31 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.14.5] fix /sys/class/net/<if>/wireless without dev->get_wireless_stats
Date: Tue, 3 Jan 2006 19:05:50 +0200
User-Agent: KMail/1.9.1
References: <200601021349.32823.arvidjaar@mail.ru> <200601022015.16580.arvidjaar@mail.ru> <200601031852.27386.ismail@uludag.org.tr>
In-Reply-To: <200601031852.27386.ismail@uludag.org.tr>
Cc: netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601031905.50314.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salı 3 Ocak 2006 18:52 tarihinde şunları yazmıştınız:
> Pazartesi 2 Ocak 2006 19:15 tarihinde şunları yazmıştınız:
> > I accidentally used wrong lkml address, so I resend it now with proper
> > format.
> >
> > dev->get_wireless_stats is deprecated but removing it also removes
> > wireless subdirectory in sysfs. This patch puts it back.
> >
> > Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
>
> Did this make it to 2.6.15?

According to Andrey it didn't, but since Linus you are talking about not 
breaking userspace, without this patch many userspace applications and 
scripts are broken so at least can we put this in 2.6.15.1 ? It doesn't make 
any sense when you leave userspace broken obviously ( there is a bugzilla 
entry and a ready patch ) and talking about userspace compatibility at the 
same time.
