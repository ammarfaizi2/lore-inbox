Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVERR5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVERR5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVERR5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:57:14 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:52930 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262200AbVERR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:56:48 -0400
Message-ID: <428B82A5.6080705@stesmi.com>
Date: Wed, 18 May 2005 20:00:05 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       MCU.Tools@silabs.com
Subject: Re: Linux support for SiLabs CP210x devices
References: <20041118173908.GA10667@kroah.com> <20050518155815.GA16544@kroah.com>
In-Reply-To: <20050518155815.GA16544@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Greg.

> Back in November of last year, I wrote about how SiLabs were
> distributing a binary only version of a usb-serial driver for Linux that
> was violating the GPL <http://thread.gmane.org/gmane.linux.kernel/256403>
> 
> Well, it looks like SiLabs and MCCI have finally released the source
> code to their driver, but in obfuscated form.  I've attached the .zip
> file to this message so that everyone can see this horrible nightmare of
> a "driver".  As per the GPL, they are still violating the license as
> obfuscated code releases is not allowed.  And as such, they are still
> violating my copyright, and the copyrights of a few other kernel
> developers.
> 
> So, just to re-iterate, I very soundly do not recommend ever buying any
> devices from this company, as if this is the way they treat well
> established legal issues, who know what else they have done...
> 
> Oh, and if you don't want to go through the trouble of opening up the
> zip file, I've included inline their header file, in all of it's glory,
> with no changes made by me at all, below.
> 
> And yes, if you notice the 2.6 kernel does now support this device, but
> that is because of some people reverse engineering the device.  It was
> by no help of the company involved (when seeing this code, those
> developers just laughed and said it would be more work to try to read it
> than to finish up the driver itself.)

Is this for real? What exactly do they think they're trying to pull
here?

I've seen borderline violations but this .. this .. this ..

If the .h file was bad, the .c's are worse.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCi4KkBrn2kJu9P78RAum2AJ9ead+TvBLTbPVW2gvfUXFlY/9cGwCfWmud
Trfomjn4d+Wd1HHw/IAdlvQ=
=WWVK
-----END PGP SIGNATURE-----
