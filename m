Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGaEkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGaEkv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVGaEkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:40:51 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:58647 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261606AbVGaEkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:40:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mIicT+gi0LymN0EPvLYJuDTsHO6aU5Ub1BHS/Q8ncs15/uk7cn5ZM001dJbwcYO+dxChF7RFI2zevmiI5Q7gCkfBEuy18SGnDAyb2YxWwguuN08uUfdHfXTMi/mvimBXV64W14q/fgdW9n08xxJ5fnCvVwMEoPrmiDeGXDly0l0=
Message-ID: <42EC5659.7010300@gmail.com>
Date: Sun, 31 Jul 2005 12:40:57 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Where is place of arch independed companion
 chips?
References: <42EB6A12.70100@varma-el.com>
In-Reply-To: <42EB6A12.70100@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Volkov wrote:
> Hi Greg,
> 
> While I write driver for SM501 CC (which have graphics controller, USB
> MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
> I bumped with next ambiguity:
> Where is a place of this chip's Kconfig/drivers in
> kernel config/drivers tree? May be create new node in drivers subtree?
> Or put it under graphics node (since it's main function of this CC)?

You will have to split your driver (graphics under drivers/video, usb
under drivers/usb, ac97 under sound, video capture under drivers/media,
etc.

Tony

