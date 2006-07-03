Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWGCPnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWGCPnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWGCPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:43:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:59240 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932080AbWGCPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:43:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NxscQ74UVxegfNoegx9W0meZITIdKMZ5n2L8uf0J5E7oVT1sux2wir9kC/ozkpKVzb9VVYm56S0ELBwuKtdtdBhAw610M4me1PfAz7bAZnL7Gva1yz3lvb0NCTkoVFCBgNz6U+DaUJmNQN0bDKMuQzZQL+hZ0PaGSjeSB5QFHZ0=
Message-ID: <ef88c0e00607030843q3cf32c1q40ae8fa8055b025f@mail.gmail.com>
Date: Mon, 3 Jul 2006 08:43:13 -0700
From: "Ken Brush" <kbrush@gmail.com>
To: "Andy Gay" <andy@andynet.net>
Subject: Re: [linux-usb-devel] [PATCH] Airprime driver improvements to allow full speed EvDO transfers
Cc: "Greg KH" <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1151646482.3285.410.camel@tahini.andynet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151646482.3285.410.camel@tahini.andynet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Andy Gay <andy@andynet.net> wrote:
>
> Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
> That patch added multiple read urbs and larger transfer buffers to allow
> data transfers at full EvDO speed.
>
> This version includes additional device IDs and fixes a memory leak in
> the transfer buffer allocation.
>
> Some (maybe all?) of the supported devices present multiple bulk endpoints,
> the additional EPs can be used for control and status functions.
> This version allocates 3 EPs by default, that can be changed using
> the 'endpoints' module parameter.
>
> Tested with Sierra Wireless EM5625 and MC5720 embedded modules.
>

With my aircard 580, I get 6 TTYUSB devices and a Urb too big message.
You should probably take the 580 out of the driver unless someone
actually has one and it works for them.

-Ken
