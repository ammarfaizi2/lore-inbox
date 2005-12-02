Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbVLBLcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbVLBLcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbVLBLcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:32:13 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:57517 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751787AbVLBLcM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:32:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mC/vSKh1+3FvqOrJQVJUafbcZq6ueXO5IEUxNjlbY9MpehRlZwZM2uWiLrQVjiGJIzDevDZgsdRaK21rO4EDH+fxExARwQQScXiqSzP5vr6bZO8UdQeQcKd2KAmqrOSc94c6l46mVCqPfDW+4M+EeaWFoTwrR0npvl9W7VOAkZE=
Message-ID: <6278d2220512020332y686d7436y42f3b09c5450267d@mail.gmail.com>
Date: Fri, 2 Dec 2005 11:32:10 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: rheflin@atipa.com
Subject: Re: What does lspci -vv "DEVSEL=slow" and "DEVSEL=medium" mean?
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The device select settings tells the PCI bus how many bus clock ticks
are required between certain PCI bus phases and is dictated by the PCI
device on the bus. It sounds like one of the cards you have has an
older revision ASIC/chip.

Roger Heflin wrote:
> Hello,
>
> I have 30+ machines, one machine is slower on using an
> infiniband card than the than the others,
> everything we can find is the same except on the "lspci -vv" the
> slow machine reports:
>
> "DEVSEL=slow"
>
> And all of the rest report:
>
>  "DEVSEL=medium"
>
> Both machines have the same bus speed listed, but this is
> known to be somewhat shakey on the driver it is using.
>
> What exactly does this mean?
>
> We know the bios version is the same and we believe the
> bios settings are the same, and that the card
> is identical, and in the same slot, and that everything else
> is the same.
>
>                        Roger
___
Daniel J Blueman
