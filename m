Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTLOKvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLOKvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:51:53 -0500
Received: from kuravelli.mail.saunalahti.fi ([195.197.172.113]:35815 "EHLO
	kuravelli.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S263478AbTLOKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:51:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
In-Reply-To: <fa.m5245vp.h0ukb5@ifi.uio.no>
References: <fa.iaibikf.1l5injd@ifi.uio.no> <fa.m5245vp.h0ukb5@ifi.uio.no>
Reply-To: as@sci.fi
Date: Mon, 15 Dec 2003 12:56:02 +0200
Message-Id: <20031215105602.8E693B802@hylsy.jippii.fi>
From: as@saunalahti.fi (Anssi Saari)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   -- modules don't autoload for some reason (though I'm sure that could
>      be solved),

I've had this too, with autofs4 and 3c59x. After patching lirc into the
kernel, the only real issue is with the console. I found a patch for radeonfb,
but didn't get anywhere with it.

The rest of my problems is userland stuff:

- Murasaki (a hotplug agent) doesn't react when USB things are plugged in
- swapon -a takes two minutes to complete for some reason
- rpc.lockd doesn't start, it says lockdsvc: Function not implemented. I don't
  know if I really need this anyway, nfs seems to work fine
- zsh doesn't complete make targets like menuconfig
- I'd also like to point out that cdrecord isn't sufficient for my 
  CD writing needs, I need cdrdao too and it doesn't seem to support
  direct access to ATAPI drives. 

