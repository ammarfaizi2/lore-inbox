Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWANRrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWANRrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWANRrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:47:36 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:28024 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750724AbWANRrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:47:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t9/6JNDC3IJS3AArmsMTM8WXvBj+zEuMc/kYiX6hDa+YwNQDCm4hjGYgaCdCYNIHFJTbKpWdv5e5e7Otemb+8cseJhFw1yYUpbbfJtWrDo3Yzn5SbRpHck48YGF5Ig43RmhtH1UyTAqcB/+dQrSCDSM4hnEhVvbGVZoy9hHSNJ4=
Message-ID: <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
Date: Sat, 14 Jan 2006 18:47:31 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>
In-Reply-To: <1137255183.20915.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060114152119.GN29663@stusta.de>
	 <1137255183.20915.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2006-01-14 at 16:21 +0100, Adrian Bunk wrote:
> > Split PDC202XX_FORCE selection into two independ option and allow user
> > select it only for specific driver.
>
> Seems pointless. We should always grab the raid cards. The option itself
> is a mistake

Alan is right, these cards should always be grabbed in 2.6.x kernels.
This option is a leftover from earlier 2.4.x days when Promise binary
driver was available for using software RAID.

Could somebody submit a patch removing CONFIG_PDC202XX_FORCE?

Bartlomiej
