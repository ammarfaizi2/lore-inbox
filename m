Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbRBMQZr>; Tue, 13 Feb 2001 11:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129467AbRBMQZh>; Tue, 13 Feb 2001 11:25:37 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:44555 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129285AbRBMQZ0>; Tue, 13 Feb 2001 11:25:26 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE042@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Elmer Joandi'" <elmer@linking.ee>, linux-kernel@vger.kernel.org
Subject: RE: USB mouse jumping
Date: Tue, 13 Feb 2001 08:24:59 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Elmer Joandi [mailto:elmer@linking.ee]
> 
> I dont know, if it is bug or feature, but, 
> 
>  USB mouse jumps around (between) /dev/input/mouse0 and mouse1
>  when taken out and put back in(to same connector), 2.4.0 kernel.
> 
> Annoys, should not be the default behaviour, IMHO.

If USB mice had serial numbers (like some USB storage devices
do), then we could tell that it's the same mouse on the
same connector and not change from mouse0 to mouse1.
Currently it looks like a new device attachment.

One possible solution is for you to use /dev/usb/mice,
which is all USB mice merged into one input stream.


~Randy_________________________________________
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

