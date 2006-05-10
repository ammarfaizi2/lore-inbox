Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWEJH0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWEJH0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWEJH0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:26:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41435 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964841AbWEJH0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:26:07 -0400
Date: Wed, 10 May 2006 09:25:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Aaron Cohen <aaron@assonance.org>, linux-kernel@vger.kernel.org
Subject: Re: USB storage emulation
In-Reply-To: <20060509223022.GA21385@kroah.com>
Message-ID: <Pine.LNX.4.61.0605100922200.27657@yvahk01.tjqt.qr>
References: <727e50150605090923k5796cbfcy99204c802a393573@mail.gmail.com>
 <20060509223022.GA21385@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any way currently to connect two computers via usb cable and
>> have one of them pretend to be a usb storage device for the other?
>
>Without special hardware, no.
>With special hardware, yes.

Storage devices usually have a fixed disk size, but when you want to 
export "/" through a storage device, this becomes a bit problematic, 
since one can resize the partition online, mount subtrees, etc. etc. Better 
try Ethernet-over-USB and some sort of networked filesystem.


Jan Engelhardt
-- 
