Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbXAPOIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAPOIZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXAPOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:08:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:24867 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXAPOIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:08:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ewtat+Mx7ZY1blKQ/vzoBMGZ4/RTMXlGlN1w53l2cDDXgfebLRz3yKhpMmXNi8GOoMLeXD8Sb+f6hqEki09UWXUZfUP44cFLKCpxpIDTKD6Fh5pHoTFci7VvPAg/4fPK+ragVAlAA1XWyaTCo5AYxdKI/KyP7gCmYDi2OmE63UU=
Message-ID: <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com>
Date: Tue, 16 Jan 2007 09:08:21 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Linux usb mailing list" <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20070116135727.GA2831@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070116135727.GA2831@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/07, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I started using el-cheapo usb mouse... only to find out that it breaks
> suspend to RAM. Suspend-to-disk works okay. I was not able to extract
> any usefull messages...
>
> Resume process hangs; I can still switch console and even type on
> keyboard, but userland is dead, and I was not able to get magic sysrq
> to respond.

Are you using hid or usbmouse?

-- 
Dmitry
