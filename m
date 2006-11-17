Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933630AbWKQOxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933630AbWKQOxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933636AbWKQOxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:53:19 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:31848 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S933630AbWKQOxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:53:19 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] usb: generic calibration support
Date: Fri, 17 Nov 2006 15:53:37 +0100
User-Agent: KMail/1.9.5
Cc: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200611161125.38901.hs4233@mail.mn-solutions.de> <200611170912.29317.hs4233@mail.mn-solutions.de> <d120d5000611170616m73268428me0840444bca73dff@mail.gmail.com>
In-Reply-To: <d120d5000611170616m73268428me0840444bca73dff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171553.38164.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe tslib handles this.

The special X server "KDrive" supports tslib, this is used in 
many embedded projects, e.g. by images created via 
http://www.openembedded.org. But mainline X.org server, e.g. 
what is in Debian unstable (7.1.0), doesn't support tslib.

Also I don't know if X/tslib allows re-calibration on-the-fly, 
but I guess it does. However, tslib usually does not work via 
the input subsystem (/dev/input/eventX is just one of them), 
most devices use proprietary kernel interfaces.


Qt/Embedded for Qt 2 and Qt 3 doesn't handle tslib 
out-of-the-box, (heck, the don't even know 
about /dev/input/eventX), but patches exist.



But I think we can stop this thread now :-)
