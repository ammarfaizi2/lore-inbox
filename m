Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424351AbWLBSdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424351AbWLBSdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424357AbWLBSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:33:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:3933 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424351AbWLBSdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:33:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajfzJPGTKEf2ocDu3JWfE9Zb3WBcPh5kmLjIPZmjbp//9HeM/VCm0xBoAA1eSJiiaZKYXhxNjjybZONZs/pJWTJb3Ro+fJM9QPOjhFwDvMnKfF0DONYMXBNqwjNUHnU0TYn36nJmhVhJlKXFfXSKLx/c+BzAhyA4QPB//DSNDSo=
Message-ID: <571a92f0612021033q37cb64e4hb2054f6250d4b522@mail.gmail.com>
Date: Sat, 2 Dec 2006 11:33:36 -0700
From: "David Lopez" <dave.l.lopez@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061202125235.GB4773@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
	 <20061202125235.GB4773@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > From: David Lopez <dave.l.lopez@gmail.com>
> >
> > This driver adds support for LabJack U3 and UE9 USB DAQ
> > devices.
>
> WTF is DAQ?

DAQ is short for data acquisition.  I should change so it's not abbreviated.


> > +       For a user-space API and usage examples, please
> > visit the LabJack
> > +       downloads web page at
> > <http://www.labjack.com/downloads.php> and go
> > +       to the specific device's downloads page.
>
> If it needs userland driver, anyway, why not libusb?

Thanks for pointing this out.  I'll look into using this and see if it
is stable enough for the devices needs.  If it is I might end up using
this as opposed to having our own kernel driver.


David
