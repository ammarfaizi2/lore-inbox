Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUJLXPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUJLXPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUJLXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:15:35 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:19975 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268052AbUJLXPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:15:18 -0400
Date: Wed, 13 Oct 2004 09:14:46 +1000
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [HID] Fix hiddev devfs oops
Message-ID: <20041012231446.GA25318@gondor.apana.org.au>
References: <20041005124914.GA1009@gondor.apana.org.au> <20041011172147.GA3066@logos.cnet> <20041012212153.GA24663@gondor.apana.org.au> <20041012152343.5b70cbd3@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012152343.5b70cbd3@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 03:23:43PM -0700, Pete Zaitcev wrote:
> 
> Herbert, I'm sorry for the wait. Marcelo asked me to take care of this,
> but I kept postponing it because I wanted to look closer, and this and
> that... It looks entirely reasonable and my hid devices continue to work,
> but I haven't tested hiddev (UPS or something ?).

Yes that's exactly the situation I'm in (APC UPS via USB) and it does fix
the OOPS for me when hid is unloaded with the UPS connected.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
