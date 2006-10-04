Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161933AbWJDSVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161933AbWJDSVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161937AbWJDSVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:21:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:899 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161933AbWJDSVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:21:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/Prq1WrsogrFrkf3xrwU3A6wurDbxunNKS3hVNZpKu8aGTAMgaOgVF4RVI+7qYMvVElYSXS3raa5P93Tv8rkNMfoI/Fp2lErcKBODcuBfE/Wu18QyEIe+7u1l1M//6vCDk1UwoqhT5lsiSLme2PSy0Z9GYzd7AlaLCrFJSDGbI=
Message-ID: <1defaf580610041121v27461d15j5491b3bb8153d9df@mail.gmail.com>
Date: Wed, 4 Oct 2006 20:21:29 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.18 V8] drivers: add LCD support
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <653402b90610041007w7ec4eca4g806c307c47075a13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061004180615.6a81e4c7.maxextreme@gmail.com>
	 <20061004094934.b780c8c5.rdunlap@xenotime.net>
	 <653402b90610041007w7ec4eca4g806c307c47075a13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> On 10/4/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> >
> > Couldn't you make the class be "auxdisplay" also?
> >
>
> I don't really know what would be the best. I think if anyone adds a
> driver for any other kind of display (example: OLED), he/she can
> create a oledclass, that maybe need more funcionality than just the
> simple lcdclass.

There's already an lcd_class in drivers/video/backlight/lcd.c with
name "lcd". Could be confusing to have an lcdclass_class with name
"LCD" as well...

Haavard
