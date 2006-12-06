Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935791AbWLFPlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935791AbWLFPlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935871AbWLFPlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:41:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:56119 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S935791AbWLFPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:41:12 -0500
Date: Wed, 6 Dec 2006 16:39:50 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
In-Reply-To: <d120d5000612060731s3e1b4b6fnb8e93b970e91a852@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612061633230.29624@jikos.suse.cz>
References: <200612061803324532133@gmail.com>  <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
  <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com> 
 <1165415924.2756.63.camel@localhost>  <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
  <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com> 
 <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
 <d120d5000612060731s3e1b4b6fnb8e93b970e91a852@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Dmitry Torokhov wrote:

> If Greg is OK with that I would start with truly mechanical merge (no 
> now data structures, just move the files around) and merge this ASAP, 
> before we hit -rc1 or -rc2 at the latest. Then you can start puling up 
> your changesin the separate git tree.

The first of the 8 patches which currently exist just moves things around 
physically. Just that is not enough, unfortunately, some tweaking is 
needed anyway (static functions, new headers, Kconfig changes, etc), so I 
think it might maybe be better to take the bunch of all 8 patches 
initially as a whole, as they really don't do too intrusive changes to the 
code, and could stay in tree for some testing (though I of course tested 
them to some extent) together.

> Take up Marcel on his suggestion ;) I could set up a tree too but I am 
> afraid I won't have enought time at the moment.

:) Thanks

-- 
Jiri Kosina
SUSE Labs
