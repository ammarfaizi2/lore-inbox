Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbUJ1ILq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbUJ1ILq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUJ1ILp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:11:45 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:19435 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S262818AbUJ1ILl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:11:41 -0400
Message-ID: <4180A9A4.4000503@lbsd.net>
Date: Thu, 28 Oct 2004 08:11:16 +0000
From: Nigel Kukard <nkukard@lbsd.net>
Organization: Linux Based Systems Design
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net> <200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Try to reproduce without it and/or
>contact nvidia on the issue
>--
>vda
>  
>

Problem is not related to the nvidia driver.

OOPS is 100% reproducable. I boot into X, and run    eog 
/mnt/camera/dcim/100cresi    and BANG.

I've reproduced it on 3 boxes I have, each with different usb adapter 
hardware and only 1 with the nvidia driver loaded.

It seems to be when eog (eye of gnome) loads thumbnails that this happens.


Regards
Nigel Kukard
