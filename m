Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVCOURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVCOURr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVCOURc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:17:32 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:38012 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261793AbVCOUOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o1AGXU4Xm34BKe3hq6v5F4a5Y7SUBm+7s8Mv6kfyf823kwD8zQwYt2vmEMQxO4PU4O9dB2yAA4fxYCCFrxKwljK1kszICC7N4T8sB8dALdCpoQp1ZvKtWqpWe9fnHJaYDl9fpnGtcvMr9VzQNV5KV3Oh9r/JHvAKK1XiEKM9et0=
Message-ID: <d120d50005031512143929e39f@mail.gmail.com>
Date: Tue, 15 Mar 2005 15:14:35 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050315195121.GA27408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
	 <20050315190847.GA1870@isilmar.linta.de>
	 <20050315195121.GA27408@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 11:51:21 -0800, Greg KH <greg@kroah.com> wrote:
> 
> class interfaces are not going away, there's a good need for them like
> you have pointed out.  I'm not expecting to just delete those api
> functions tomorrow, but slowly phase out the use of them over time, and
> hopefully, eventually get rid of them.  I think that with my USB host
> controller patch, I've proved that they are not as needed as you might
> think they were.
> 

It looks to me (and I might be wrong) that USB was never really
integrated into the driver model. It was glued with it but the driver
model came after most of the domain was defined, and it did not get to
be "bones" of the subsystem. This is why it is so easy to deatch it.

-- 
Dmitry
