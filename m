Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbTFCOeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbTFCOeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:34:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24812
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265039AbTFCOeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:34:44 -0400
Subject: Re: siimage driver status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu>
References: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054648192.9234.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 14:49:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 15:11, Wm. Josiah Erikson wrote:
> Is there some silly hack I can do to the driver code to force all devices 
> to DMA on bootup? Everything works fine except for that. I'm using 
> 2.4.21-rc6-ac1

-ac2 knows the firmware doesn't intialise DMA mode and shouldn't be used
as a safety guide.


