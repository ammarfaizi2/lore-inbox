Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbTLHMlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 07:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbTLHMlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 07:41:18 -0500
Received: from mid-2.inet.it ([213.92.5.19]:26248 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S265383AbTLHMlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 07:41:17 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Greg KH <greg@kroah.com>, maxk@qualcomm.com
Subject: Re: 2.6 Test 11 Freeze on USB Disconnect
Date: Mon, 8 Dec 2003 13:40:55 +0100
User-Agent: KMail/1.5.4
Cc: "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>,
       linux-kernel@vger.kernel.org
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com> <200312080223.54285.cova@ferrara.linux.it> <20031208074630.GC24585@kroah.com>
In-Reply-To: <20031208074630.GC24585@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200312081340.55967.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 08:46, lunedì 08 dicembre 2003, Greg KH ha scritto:

> > >
> > > Is there any way you can see if an oops happened?  Without that it will
> > > be pretty hard to debug this.
> >
> > This seems the very same problem that I've got some time ago with test9
> > and never fixed (AFAIK). I'll bet that the SCO support is active.
>
> Did you let Max know about this?
>
> (I've cced him and left the rest of the oops report below...)
>
> greg k-h

Yes, I've CC'ed him on my original mail. Another thing to note is that the usb 
BT dongle is left plugged the kernel oops occurs at shutdown, probably when 
some module is removed.
I can capture this oopses (by serial link) also, if needed.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

