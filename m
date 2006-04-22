Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWDVT7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWDVT7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDVT7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:59:50 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:10186 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbWDVT7t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:59:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QrFeFpNbjJEzY9O2a7sFijGHxofqsS2XyT17IcXE2kFSp9LA1oqrBsPGPH4Z7f3sHDWNmxeu0dVcc/v179K+lZQGqN9qFFU/ov4DpJD7jGHK/qncdqA4MnBKYT/+LLEfprcNbdCsCCNqcukh6tNLLjlYs3hjMtvSqwBy+bjAL90=
Message-ID: <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com>
Date: Sat, 22 Apr 2006 16:59:48 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usbkbd not reporting unknown keys
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, dtor_core@ameritech.net
In-Reply-To: <20060422185402.GC10613@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
	 <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
	 <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
	 <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
	 <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com>
	 <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com>
	 <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com>
	 <20060422185402.GC10613@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sat, Apr 22, 2006 at 03:11:30PM -0300, Matheus Izvekov wrote:
> My opinion is that usbkbd serves as:
>
>         a) an example usb/input driver
>         b) for embedded systems where usbhid is too large
>
> For keyboards with extra keys, use usb-hid.
>
> --
> Vojtech Pavlik
> Director SuSE Labs
>
Sorry, weve came to that conclusion, the thread got to somethign else
entirely different. ill summarize here my problem so that you dont
need to read it all over again.

1) I have a microsoft multimedia keyboard, and the hid driver doesnt
maps all the multimedia keys. The output of the hid debug output was
posted previously in the thread.
2) For some reason, th hid driver register lots of absolute axis and
joystick buttons that dont seem to work at all, no matter what i
press. I Asked if it would be possible to blacklist those. Currently
the device registers a js interface with so many axis and buttons that
some programs even segfault while reading it. This interface is
useless as far as i can see.
If you need more detailed information please ask me.

Maybe the thread subject should be changed to something more
apropriate, do so if it pleases you.
