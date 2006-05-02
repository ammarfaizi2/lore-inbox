Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWEBVwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWEBVwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWEBVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:52:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:57869 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964994AbWEBVwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:52:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C4eOOqLmlL67zmkFMIbzw8+0lT6zjtDy30ebUmAdZc4oKyIg9GEP/LYTunjhakoPH8RcxO37sJrGfBDWa2E1EnR+NiY2VSoXCvcQiPyWGTeFu8yu3/35Eg23r0b4SOJGMULcjO2NqKujQ1gCPRHtJSVTGR06bSxcgG927+QPmfE=
Message-ID: <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
Date: Tue, 2 May 2006 17:52:09 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Dave Airlie <airlied@gmail.com> wrote:
> Jon stop being so dramatic, this is just like letting userspace map
> the BARs, without ownership through sysfs, which is a good thing, you
> can still map /dev/mem, look we have lots of ways to shoot ourselves
> in the foot, if we *want* to.

So why don't we just build a VGA class driver or make null fbdev
drivers? That solution works and stays in the model of one driver per
device and user space using a device driver to control the hardware.
This is a known problem and we have a valid solution, why build a new
API perpetuating the old model? If there wasn't a workable alternative
available I wouldn't be complaining.

Have you seen this method of getting root from X?
http://www.cansecwest.com/slides06/csw06-duflot.ppt
It is referenced from Theo de Raadt interview on kerneltrap
http://kerneltrap.org/node/6550

I am happy to see progress being made at getting X out of the PCI bus business.

--
Jon Smirl
jonsmirl@gmail.com
