Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVBUWqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVBUWqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVBUWqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:46:35 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:60154 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S262165AbVBUWq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:46:29 -0500
Message-ID: <421A6450.8070404@nodivisions.com>
Date: Mon, 21 Feb 2005 17:44:32 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>            <421A4375.9040108@nodivisions.com> <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
In-Reply-To: <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> See the thread rooted here:
>  
> Date: Wed, 03 Nov 2004 07:51:39 -0500
> From: Gene Heskett <gene.heskett@verizon.net>
> Subject: is killing zombies possible w/o a reboot?
> Sender: linux-kernel-owner@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Reply-to: gene.heskett@verizon.net
> Message-id: <200411030751.39578.gene.heskett@verizon.net>

Also, one of the things mentioned in that thread is that whenever a driver 
is waiting on I/O from a piece of hardware, there should always be some 
timeout code.  Is that the root of the permanent D state?  Is it always a 
process waiting on a piece of hardware that should be eventually timing out, 
except the timeout code isn't there?

-Anthony DiSante
http://nodivisions.com/
