Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSLCMfv>; Tue, 3 Dec 2002 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSLCMfv>; Tue, 3 Dec 2002 07:35:51 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:7685 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S261173AbSLCMfu>; Tue, 3 Dec 2002 07:35:50 -0500
Date: Tue, 3 Dec 2002 13:44:00 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: Fridtjof Busse <fridtjof@fbunet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error with 2.4.20-ac1
Message-ID: <20021203124359.GA19242@steffen-moser.de>
Mail-Followup-To: Fridtjof Busse <fridtjof@fbunet.de>,
	linux-kernel@vger.kernel.org
References: <200212031135.49423@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212031135.49423@fbunet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

* On Tue, Dec 03, 2002 at 11:35 AM (+0100), Fridtjof Busse wrote:

> If I change an option (make menuconfig) and run 'make dep && make clean 
> bzImage modules modules_install' afterwards, I get:

You can try doing the "make clean" at first and the "mape dep" 
then, i.e.:

  make clean dep bzImage modules modules_install

HTH!

Regards,
Steffen
