Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUHYErE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUHYErE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHYErD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:47:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58123 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268525AbUHYEqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:46:16 -0400
Date: Wed, 25 Aug 2004 06:45:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lcaron@apartia.fr,
       linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-ID: <20040825044551.GH1456@alpha.home.local>
References: <412B5B35.7020701@apartia.fr> <20040824092533.65cb32da.rddunlap@osdl.org> <20040824113407.287f0408.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824113407.287f0408.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Aug 24, 2004 at 11:34:07AM -0700, David S. Miller wrote:
 
> Oh on the contrary, I've never seen a call to request_firmware()
> in any copy of the tg3 driver and that's strange being that I'm
> the maintainer. :-)
> 
> People, if you're going to use patched up kernels, report your
> problems to the people you got the kernel from.  Thanks.

I think that he's using a debian kernel and thinks he's using a vanilla
kernel while it's not. I've just installed one on an ultra5 and discovered
a directory with about 60 patches, one of which was dedicated to the removal
of this "undesired closed-source tg3 firmware" ! I was happy not having lost
time debugging this on a machine with a tg3 NIC.

I find it a bit odd when distro makers don't clearly put their name in their
kernels, because it confuses people who honnestly think it's a vanilla one.
Indeed, I'm yet not really sure what they put in the kernel that booted my
sparc, but it's not a problem now since I've replaced it ;-)

Cheers,
Willy

