Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRIEBv7>; Tue, 4 Sep 2001 21:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRIEBvu>; Tue, 4 Sep 2001 21:51:50 -0400
Received: from zok.SGI.COM ([204.94.215.101]:49878 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270073AbRIEBvk>;
	Tue, 4 Sep 2001 21:51:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6 
In-Reply-To: Your message of "Mon, 03 Sep 2001 15:05:29 +0200."
             <20010903150529.J699@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Sep 2001 11:51:11 +1000
Message-ID: <16601.999654671@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 15:05:29 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>On Mon, Sep 03, 2001 at 02:50:47AM +0100, Alan Cox wrote:
>> 2.4.9-ac6
>> o	Add MODULE_LICENSE tags to telephony		(Robert Love)
>> o	Add MODULE_LICENSE tags to drivers/video	(Robert Love)
>> o	Add MODULE_LICENSE tags to zorro		(Robert Love)
>
>what's the point of such information? If something I would understand to
>specify the licence of a module when it's _not_ GPL.

The next version of insmod will warn about modules with no
MODULE_LICENSE at all and inform about modules with proprietary
licences.  Both cases will mark the kenrel as tainted which will show
up on bug reports.

