Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSACBme>; Wed, 2 Jan 2002 20:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288109AbSACBmY>; Wed, 2 Jan 2002 20:42:24 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:48395 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S288108AbSACBmQ>; Wed, 2 Jan 2002 20:42:16 -0500
Subject: Re: CML2 funkiness
From: Miles Lane <miles@megapathdsl.net>
To: Andrew Rodland <arodland@noln.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, LKML <linux-kernel@vger.kernel.org>,
        David Relson <relson@osagesoftware.com>
In-Reply-To: <web-54762827@admin.nni.com>
In-Reply-To: <web-54762827@admin.nni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 02 Jan 2002 17:42:47 -0800
Message-Id: <1010022168.1142.12.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing other problems.  Using CML2 with a 2.4.18-pre1
tree, I was unable to create a kernel that would boot.
It kept crashing with messages stating that the rivafb driver
did not support 8-bit color depth.  I tried tweaking my
configuration for a while, but finally reverted to CML2
and was then able to get a working kernel.  I'll investigate
further and send along a diff of the working and broken
configuration files.

Another thing I notice is that when I create a configuration
using CML2, then switch to CML1 and run "make oldconfig"
using the same kernel tree, it appears there are configuration
options that never got set in the CML2 .config file.
I suppose this may simply be due to CML2 writing out the 
options in a different order.

	Miles

