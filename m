Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVDFNqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVDFNqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVDFNqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:46:51 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:23046 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262208AbVDFNqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:46:48 -0400
Message-ID: <4253E938.4040306@aitel.hist.no>
Date: Wed, 06 Apr 2005 15:50:48 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Button <vger.kernel.org@joebutton.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1: Mouse stopped working
References: <200504061319.39431.vger.kernel.org@joebutton.co.uk>
In-Reply-To: <200504061319.39431.vger.kernel.org@joebutton.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Button wrote:

>Hi.
>
>My mouse stopped working in x.org with 2.6.12-rc1. Problem is still there in 
>2.6.12-rc2. Works on 2.6.11.x with same .config (except for make oldconfig / 
>defaults).
>
>Mouse is ImPs2, xorg.conf is using /dev/input/mouse0, which seems to be 
>present. Board is Asus p4p800 deluxe.
>  
>

Yes, but it may have moved to mouse1 or some such.
Do you have a fancy keyboard with a wheel (perhaps a
volume control) on it?  That may have become
a "mouse" now.

If this is a single-seat computer, simply use /dev/mice.
If not, try the various mouseX devices till you find the right one.

Helge Hafting
