Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWF0RpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWF0RpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWF0RpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:45:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26296 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161246AbWF0RpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:45:15 -0400
Message-ID: <44A16E9C.70000@zytor.com>
Date: Tue, 27 Jun 2006 10:45:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <p73r71attww.fsf@verdi.suse.de> <44A166AF.1040205@zytor.com> <200606271940.46634.ak@suse.de>
In-Reply-To: <200606271940.46634.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> But not for LVM where this can be fairly complex.
> 
> And next would be probably iSCSI. Maybe it's better to leave some stuff
> in initramfs. 
> 

Of course, and even if it's built into the kernel tree it doesn't have 
to be monolithic (one binary.)  Current kinit is monolithic (although 
there are chunks available as standalone binaries, and I have gotten 
requests to break out more), but that's mostly because I've been 
concerned about bloating the overall size of the kernel image for 
embedded people.

	-hpa
