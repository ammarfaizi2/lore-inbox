Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSEUUAN>; Tue, 21 May 2002 16:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSEUUAM>; Tue, 21 May 2002 16:00:12 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:33039 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S316578AbSEUUAL>; Tue, 21 May 2002 16:00:11 -0400
Date: Tue, 21 May 2002 16:00:12 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] RE: What to do with all of the USB UHCI drivers in the kernel ?
Message-ID: <20020521160012.D2645@sventech.com>
In-Reply-To: <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002, Maksim (Max) Krasnyanskiy <maxk@qualcomm.com> wrote:
> I'm gonna speak for Bluetooth USB devices.
> I do have bunch of things like Kodak digi camera, Sony DV camcorder, CF 
> reader, etc. But they don't
> seem to care much about which HCD is used and work equally well with both 
> usb-uhci and uhci drivers.
> 
> I used to be a uhci driver fan :). But starting somewhere from 2.4.16 or so 
> Bluetooth devices work much better
> with usb-uhci driver (not all devices but most of them). Even thought 
> Bluetooth is pretty slow (about 700kbps)
> performance difference is sometimes pretty significant 20-30% (ie usb-uhci 
> driver is faster).
> 
> So basically I vote for usb-uhci. However some things will have to be 
> fixed. We (Bluetooth folks) have couple
> of devices that refuse to work with usb-uhci (I didn't test the latest 
> usb-uhci though).

Please test the latest version of the drivers. Both uhci and usb-uhci
have had various bug fixes. I'm sure the performance problems you've had
with uhci have been fixed for a little while now.

Also, feedback about the -hcd variants would useful too since one of
those will be the only ones left for 2.5.

JE

