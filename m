Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDXSFg>; Wed, 24 Apr 2002 14:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSDXSFf>; Wed, 24 Apr 2002 14:05:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36997 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312480AbSDXSFd>;
	Wed, 24 Apr 2002 14:05:33 -0400
Date: Wed, 24 Apr 2002 10:56:02 -0700 (PDT)
Message-Id: <20020424.105602.81442098.davem@redhat.com>
To: greearb@candelatech.com
Cc: jd@epcnet.de, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CC6F22E.9060402@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 24 Apr 2002 10:58:06 -0700
   
   > But the changes are wrong, just because they work for some people
   > doesn't make the change mergeable into the main tree.
   
   Wrong is a strong word for a change that makes it work for some people without
   obvious negative side effects.

Ummm, sed 's/obvious/known/'  We don't know what the patch
even does.

   That is good news, but does not change my arguments about fixing up
   the eepro driver at all :)
   
The point is that once we see what works in the e100 driver (and Jeff
and I are making them document the bits) we can add the same fix
to eepro100.c
   
Franks a lot,
David S. Miller
davem@redhat.com
