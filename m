Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVBUT2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVBUT2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVBUT07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:26:59 -0500
Received: from [195.23.16.24] ([195.23.16.24]:991 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262074AbVBUTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:12:30 -0500
Message-ID: <421A2B18.2000102@grupopie.com>
Date: Mon, 21 Feb 2005 18:40:24 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
References: <200502211216.35194.gene.heskett@verizon.net> <200502211858.34301.oliver@neukum.org> <200502211325.55013.gene.heskett@verizon.net>
In-Reply-To: <200502211325.55013.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Monday 21 February 2005 12:58, Oliver Neukum wrote:
>[...]
>>A video stream over usb1.1 must be compressed due to bandwidth
>>available. Decompression needs cpu.
>>
> 
> Thats what I was afraid of, which makes using it for a motion detected 
> burgular alarm source considerably less than practical since the 
> machine must be able to do other things too.  Darn.  And its usb1.1 
> even when plugged into a 2.0 capable port.

Depending on the camera model you can try some bandwidth reduction 
measures to try to make it send uncompressed video:
  - reduce frame rate. Something as low as 2 fps should be enough for 
motion detection.
  - reduce requested resolution. This of course depends on whether you 
have enough resolution or not.
  - selecting gray scale images. I don't know if your motion detection 
software is greatly affected by this, or not.

USB1.1 bandwidth is enought for 640x480, 8 bits gray scale (or color, 8 
bits bayer pattern), at 3 fps.

Of course, you can always buy a USB2.0 camera :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
