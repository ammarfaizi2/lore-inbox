Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269852AbUH0AXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269852AbUH0AXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269850AbUH0AXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:23:25 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:44853
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S269796AbUH0AVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:21:54 -0400
Date: Fri, 27 Aug 2004 02:21:51 +0200 (CEST)
From: Wouter Van Hemel <wouter-kernel@fort-knox.rave.org>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
In-Reply-To: <20040826234010.GA22046@kroah.com>
Message-ID: <Pine.LNX.4.61.0408270146270.8658@senta.theria.org>
References: <33193.151.37.215.244.1093530681.squirrel@webmail.azzurra.org>
 <Pine.LNX.4.61.0408261948480.555@senta.theria.org> <20040826190701.GA13310@kroah.com>
 <Pine.LNX.4.61.0408270106440.8658@senta.theria.org> <20040826234010.GA22046@kroah.com>
PGP: 0B B4 BC 28 53 62 FE 94  6A 57 EE B8 A6 E2 1B E4  (0xAA5412F0)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Greg KH wrote:

> Having a hook in the kernel (in GPLed code) for the explicit purpose of
> allowing a binary module is not allowed.  Go read Linus's statements
> about this in the archives.
>

I understand that loading binary pieces in a stand-alone driver is an 
undesirable situation, but I think you take things too strict. Sometimes 
you must look at the meaning behind a rule, and not just take things as 
universal law. It is certainly not 'illegal', as Philips has clearly given 
permission and helped out on getting this driver included.

Indeed, as far as I understand, there is hope that this binary part will 
once be open sourced. However, rejecting Philips' contribution completely 
will not aid in getting their products supported, and we desperately need 
support for some of these devices. As I already told you, I tried 3 other 
webcams which failed to work, and I've ordered this camera (and received 
it today, for crying out loud) precisely because it works in Linux, just 
like many other people have.

> Then talk to Phillips, or Nemosoft.  I didn't rip the driver out of the
> kernel, only the hook.  Nemosoft asked that the driver be riped out, and
> that's his option.
>

But look where he has come from... He has gotten support from Philips, he 
has received lots of information (mostly under NDA apparently, sadly 
enough), and with some patience, he might have gotten a full opensource 
version. Ripping out code that Philips already supported, will not help in 
getting them to open up more.

>> Binary code is not illegal. Undesirable, maybe. But not illegal. It's not
>> even included in the kernel code. Only a hook, and it's not even a forced
>> dependency.
>
> Great, then use the version I did without the hook.  That's fine with
> me.
>

You don't seem to understand that your sense of righteousness is setting 
back a lot of people, and if you would stand up and tell them you'd 
contact Philips yourself, perhaps people would be more understanding, but 
now you just pulled one of the only (and major, and supported, and 
working) drivers without as much as an alternative or promise to attempt 
to rectify the problem thusly created. Have you at least tried to contact 
Philips to improve things constructively?

Yes, I do think that if you want to see the whole driver as opensource, 
you should at least have tried once to get it in a way you can agree with, 
and not just start removing things other people seem to have worked hard 
for to achieve. With which I don't mean that I think it's a good idea of 
Nemosoft to pull all code - he too should remember it's not only about 
him, but also about all people using this driver, and about Philips, who 
seem to have been quite supportive in the development process.

