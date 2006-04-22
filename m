Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWDVUEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDVUEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWDVUEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:04:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:38602 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751115AbWDVUEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:04:41 -0400
Date: Sat, 22 Apr 2006 22:04:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Message-ID: <20060422200455.GA10994@suse.cz>
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com> <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com> <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com> <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com> <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com> <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com> <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com> <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com> <20060422185402.GC10613@suse.cz> <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 04:59:48PM -0300, Matheus Izvekov wrote:
> On 4/22/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Sat, Apr 22, 2006 at 03:11:30PM -0300, Matheus Izvekov wrote:
> > My opinion is that usbkbd serves as:
> >
> >         a) an example usb/input driver
> >         b) for embedded systems where usbhid is too large
> >
> > For keyboards with extra keys, use usb-hid.
> >
> > --
> > Vojtech Pavlik
> > Director SuSE Labs
> >
> Sorry, weve came to that conclusion, the thread got to somethign else
> entirely different. ill summarize here my problem so that you dont
> need to read it all over again.
> 
> 1) I have a microsoft multimedia keyboard, and the hid driver doesnt
> maps all the multimedia keys. The output of the hid debug output was
> posted previously in the thread.
> 2) For some reason, th hid driver register lots of absolute axis and
> joystick buttons that dont seem to work at all, no matter what i
> press. I Asked if it would be possible to blacklist those. Currently
> the device registers a js interface with so many axis and buttons that
> some programs even segfault while reading it. This interface is
> useless as far as i can see.
> If you need more detailed information please ask me.

Just point me to the HID debug logs. (I need DEBUG enabled in both
hid-core.c and hid-input.c.) Make sure you're running an uptodate
kernel. I'll see what is needed to fix the mappings for that keyboard.

> Maybe the thread subject should be changed to something more
> apropriate, do so if it pleases you.

-- 
Vojtech Pavlik
Director SuSE Labs
