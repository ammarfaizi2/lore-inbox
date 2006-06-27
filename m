Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWF0RLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWF0RLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWF0RLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:11:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6564 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161227AbWF0RLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:11:41 -0400
Message-ID: <44A166AF.1040205@zytor.com>
Date: Tue, 27 Jun 2006 10:11:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org>	<Pine.LNX.4.64.0606271316220.17704@scrub.home>	<44A13512.3010505@garzik.org> <p73r71attww.fsf@verdi.suse.de>
In-Reply-To: <p73r71attww.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jeff Garzik <jeff@garzik.org> writes:
>> MD/DM root setup,
> 
> That would require pulling the tools for that into the kernel source right?
> Not sure that's a good idea. Do you really want /usr/src/linux/liblvm ? 
> 

Only enough to bring up the filesystem.  This is, of course, already the 
case for MD.  That code has (mostly) not yet been moved to userspace, 
but that is definitely on the road map going forward.

	-hpa

