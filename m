Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWBSQO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWBSQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWBSQO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:14:59 -0500
Received: from mx1.rowland.org ([192.131.102.7]:35079 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750789AbWBSQO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:14:59 -0500
Date: Sun, 19 Feb 2006 11:14:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: CaT <cat@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       Wolfgang =?UTF-8?B?TcO8ZXM=?= <wolfgang@iksw-muees.de>,
       <martinmaurer@gmx.at>
Subject: Re: [linux-usb-devel] Re: 2.6.15: usb storage device not detected
In-Reply-To: <20060218224924.737bd36b.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0602191113430.9165-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, Pete Zaitcev wrote:

> On Sun, 19 Feb 2006 16:19:15 +1100, CaT <cat@zip.com.au> wrote:
> 
> Thanks for the trace, CaT!
> 
> > c31f414c 744561726 S Bo:005:02 -115 31 = 55534243 00000000 00000000 00000600 00000000 00000000 00000000 000000
> > c31f414c 744561854 C Bo:005:02 0 31 >
> > c31f414c 744561863 S Bi:005:01 -115 13 <
> > c31f414c 745057444 C Bi:005:01 0 13 = 55534253 00000000 00000000 00
> > c31f414c 745057463 S Ci:005:00 s a1 fe 0000 0000 0001 1 <
> > c31f414c 745057691 C Ci:005:00 -32 0
> > c31f414c 745057750 S Co:005:00 s 02 01 0000 0081 0000 0
> > c31f414c 745058065 C Co:005:00 0 0
> > c31f414c 745058072 S Co:005:00 s 02 01 0000 0002 0000 0
> > c31f414c 745058314 C Co:005:00 0 0
> > c31f414c 745058386 S Bo:005:02 -115 31 = 55534243 01000000 00000000 00000600 00000000 00000000 00000000 000000
> > c31f414c 745058437 C Bo:005:02 0 31 >
> > c31f414c 745058444 S Bi:005:01 -115 13 <
> > c31f414c 750057024 C Bi:005:01 -104 0

Perhaps the device doesn't like the way you do GetMaxLUN after doing TEST 
UNIT READY.

Alan Stern

