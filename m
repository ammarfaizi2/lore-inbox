Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWCHVeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWCHVeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWCHVeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:34:02 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:24235 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932569AbWCHVeA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:34:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTT1+O+e71ukENKtl1FNCL3rHdaluSWUzdro4aUyPkKwmAIaRoHF4YsvPa92xtnqikHZdvJbOW1K5Qs6CoYajNexDmjL7+/8X4iYSc7bsDSyp0ehMkgHGiLyeWWQiz1f3ifyuB1dSxGcwXSCUmPuQhLiaZGOi4h38HrCRI+LDBI=
Message-ID: <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
Date: Wed, 8 Mar 2006 18:34:00 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
	 <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 3/8/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > Just discovered it needs usb debugging to be set. But isnt
> > inconsistent the fact that the atkbd driver does this differently from
> > the usbkbd driver? If its a good idea to print those messages by
> > default or one, why its not for the other?
>
> usbkbd will only report standard keys and is supposed in limited
> circumstances so it complaining about unknown keys is not very useful.
> Why do you need it? Doesn't hid driver work for you?
>
> --
> Dmitry
>

It works, except that i have some multimedia keys which are not
mapped. Im going to add those to the table soon, thats why i needed
those messages. So you think the usbkbd behaviour is the correct one,
and the default behaviour must be changed in the atkbd driver?
