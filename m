Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWEFNIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWEFNIa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 09:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWEFNIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 09:08:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:16751 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWEFNI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 09:08:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qGETH1gZKud7kYuQWi15zMEVL9m6AkwDwJACZ9kqfQwpBzGQiFMkWhZ93wDeY9N2THpPgCkmDWCate6psVOW8jWiRWEUNEKlwUFA8adQmRCJruxGXEvbDDRUQZcUdXArIg/9/XLEs88xhBZeX4z7TKkBGzs9LBqxxotQG/hIU2g=
Message-ID: <9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com>
Date: Sat, 6 May 2006 09:08:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Dave Airlie" <airlied@gmail.com>, "Greg KH" <greg@kroah.com>,
       "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m3d5er729f.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	 <20060505210614.GB7365@kroah.com>
	 <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	 <20060505222738.GA8985@kroah.com>
	 <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	 <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	 <9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com>
	 <m3d5er729f.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > The minimal vga driver combined with new_id scheme is very simple, it
> > works on older kernels, it does not create a new API and it tracks
> > ownership of the hardware state.
>
> But it works only with VGAs (I, for example, use setpci-alike things
> with non-VGA cards but it's dangerous - who knows if the BARs are set
> correctly if the device wasn't enabled by the kernel).

Substitute vga with the name of whatever class of device you are
working on and build it a minimal driver for it. The technique is
generic.

> --
> Krzysztof Halasa
>


--
Jon Smirl
jonsmirl@gmail.com
