Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284788AbRLEWu6>; Wed, 5 Dec 2001 17:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284789AbRLEWut>; Wed, 5 Dec 2001 17:50:49 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:49074 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284788AbRLEWuk>; Wed, 5 Dec 2001 17:50:40 -0500
Date: Wed, 5 Dec 2001 17:50:17 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: Rob Myers <rob.myers@gtri.gatech.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
Message-ID: <20011205175017.B25214@redhat.com>
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom> <3C0D7CEA.2050307@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0D7CEA.2050307@metaparadigm.com>; from michael@metaparadigm.com on Wed, Dec 05, 2001 at 09:48:26AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 09:48:26AM +0800, Michael Clark wrote:
> The code reads a 64bit detect flag from the ns chip - so I guess it
> must be bogus with some motherboards. Mine is okay. Ben??

Actually, it's 64 bit addressing that it detects.  I'll change the 
message to reflect this.

> Okay, so i'll move the register_netdev call earlier on in the
> initialisation and add any necessary unregister call for failures.

Thanks for the patch -- I've now just got to add subsystem id support to 
catch an odd 83820 on a motherboard setup that has different polarity for 
the duplex + speed inputs.  Why do hardware vendors have to be different?

		-ben
