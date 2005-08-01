Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVHALLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVHALLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 07:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVHALLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 07:11:15 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:62165 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262073AbVHALLO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 07:11:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pgdyhZdhkhJV+JPPR07k+l8fiqCNpu2mVJyKV2A5wvzSbSZ4991J0igYqde2bTL/MlpYNczAn8svF+x8dQyfdt67+awVEQd1CpQ1F9RGSrllazxK/rlhiJuvNuL0XxZadAicXpYcst/B/Gg1n1+TrlFwa5bNU5VgjvukTbc9P3w=
Message-ID: <c0140e7605080104115d111741@mail.gmail.com>
Date: Mon, 1 Aug 2005 13:11:13 +0200
From: cengizkirli <cengizkirli@gmail.com>
Reply-To: cengizkirli <cengizkirli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Mouse Freezes in Xorg on ASUS P4C800 Deluxe
In-Reply-To: <c0140e760507280333174f7e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0140e76050723082730836e7b@mail.gmail.com>
	 <9a8748490507230836584948c6@mail.gmail.com>
	 <c0140e7605072308424eb60d57@mail.gmail.com>
	 <c0140e7605072312377b348743@mail.gmail.com>
	 <c0140e7605072802236f4c3b26@mail.gmail.com>
	 <c0140e760507280333174f7e7d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, cengizkirli <cengizkirli@gmail.com> wrote:
> On 7/28/05, cengizkirli <cengizkirli@gmail.com> wrote:
> > It seems to work after comparing my .config with Andreas Baer's and also
> > setting USB Support to "built-in" and not "module". Somehow the modules
> > are unloaded or whatever. It seems to work now. Hopefully it will last...
> >
> 
> now I know why I set USB to "module": with USB "built-in" it does not reboot.
> on Debian it just prints "Rebooting..." and that's all that happens. hmm, maybe
> ACPI related, though with 2.6.13-rc3-mm2 I don't get the "executable code
> found" ACPI warnings anymore but who knows.
> 

it works with the following config:
- USB as "Module" not "builtin" to prevent reboot problems
- no USB HID support selected
- USB mouse attached via USB_to_PS/2 adapter

ergo, please be careful with attaching a USB mouse to the USB
port when you're forced to use one of those not-so-bugfree ASUS
boards like P4C800 Deluxe.
