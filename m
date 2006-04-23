Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWDWOAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWDWOAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 10:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWDWOAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 10:00:47 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:62121 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750853AbWDWOAr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 10:00:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RrFyATMOcguzYdTX6Y3j60C1T/q1lUB2eGc7mVsVQmSRRmtndSp7NK0atrroSmqilY4wGzJ2zhMsoQlU5smYmYaUkYUOZvO4ZB2SJhn/l9NxzNtUiLe+KFXtW0tJavgjNkr+W4XVnWuGyoWD03CUxNwfeTqMYTcHBDjQLMNtNDs=
Message-ID: <305c16960604230700y7e6931b3pc6cbf042e793e8ad@mail.gmail.com>
Date: Sun, 23 Apr 2006 11:00:45 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: usbkbd not reporting unknown keys
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
In-Reply-To: <20060423065818.GA12611@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
	 <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com>
	 <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com>
	 <20060422185402.GC10613@suse.cz>
	 <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com>
	 <20060422200455.GA10994@suse.cz>
	 <305c16960604221401k4e6493b6xa9c898a92c6b028d@mail.gmail.com>
	 <20060422215356.GA11798@suse.cz>
	 <305c16960604221528i2407e2d5nb8aa97c011246e71@mail.gmail.com>
	 <20060423065818.GA12611@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> Yes, this one looks much better.
>
> The keyboard part of the device is OK, but the multimedia/mouse part is
> totally FUBAR. Adding support for any keys that are not making it
> through should be trivial, but making it not appear as a crazy joystick
> is not realistically possible: The device insists on that it IS a device
> from hell with almost all possible valuators defined in the HID spec.
>
> --
> Vojtech Pavlik
> Director SuSE Labs
>

Yes, its totally crap, should have know better before buying it : /
But isnt it possible to create a blacklist for it, so the hid driver
would ignore those valuators?
Thats what devices with broken implementations deserve : )
