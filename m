Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUHDSvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUHDSvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUHDSvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:51:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:60059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267376AbUHDSv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:51:29 -0400
Date: Wed, 4 Aug 2004 11:51:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: James Morris <jmorris@redhat.com>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
In-Reply-To: <1091644663.21675.51.camel@ghanima>
Message-ID: <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
 <1091644663.21675.51.camel@ghanima>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Aug 2004, Fruhwirth Clemens wrote:
> 
> As a matter of principle I do not add additional restrictions as respect
> for the original author's efforts. But James, David or Linus might do
> that, and by accident choose these additional restrictions to be like
> those of the GPL. I would understand such action as I'd would like to
> see that every kernel code is protected by the GPL.

That's not actually what we did. I refused the code originally because I
didn't feel that Gladman's license was a proper subset of the GPL. I only
accepted it after dual-licensing under the GPL had been ok'd by Dr Brian
Gladman himself.

Note that the kernel is perfectly fine with dual-licensing: there's a
number of drivers in the kernel that can be distributed either under BSD
or GPL licenses. I hate adding restrictions too, so when we have a mix of
licenses, I much prefer allowing _both_ for that piece of code. That's why 
the current aes-i586-asm.S file has

//  ALTERNATIVELY, provided that this notice is retained in full, this product
//  may be distributed under the terms of the GNU General Public License (GPL),
//  in which case the provisions of the GPL apply INSTEAD OF those given above.

Of course, the kernel itself always uses the GPL version, but dual
licensing is how we can allow certain drivers to be maintained across
Linux and the BSD's (or other projects, for that matter). No need to 
duplicate work that way.

		Linus
