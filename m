Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUHEB1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUHEB1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHEB1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:27:42 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49037 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267538AbUHEB1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:27:39 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Date: Wed, 4 Aug 2004 18:20:50 -0700
User-Agent: KMail/1.6.2
Cc: Michael Guterl <mguterl@gmail.com>,
       "Luis Miguel =?utf-8?q?Garc=EDa?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
References: <200408022100.54850.ktech@wanadoo.es> <200408040104.00177.ktech@wanadoo.es> <944a037704080413321617ac3c@mail.gmail.com>
In-Reply-To: <944a037704080413321617ac3c@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041820.50199.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 13:32, Michael Guterl wrote:

> As stated earlier machine hangs on Starting cups.

The "usblp" driver hasn't changed recently.


> If I disconnect all 
> USB devices it boots, but when I plug my keyboard in, nothing works
> unless I hold down a key for a few seconds.  

One data point:  rc3 worked just fine for me on one machine, OHCI
and EHCI under light testing (which included a keyboard).

Please be sure to provide full debug info with future reports,
including "lspci -vv" info, "dmesg" output showing usb init
and showing the failure, info about the USB devices you're
using, and "how I broke it" info.  "alt-sysrq-t" traces are good
for kernel hangs...

There seem to be a bunch of reports floating around that
are basically "it doesn't work for me" ... and devoid of enough
info that anyone could actually track down the problem

