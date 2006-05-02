Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWEBUdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWEBUdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWEBUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:33:47 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:19362 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751271AbWEBUdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:33:46 -0400
Message-ID: <4457C228.9050209@free.fr>
Date: Tue, 02 May 2006 22:33:44 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301050.22984.ak@suse.de> <445798F6.3050102@free.fr> <200605021950.17737.ak@suse.de>
In-Reply-To: <200605021950.17737.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Does it work? 
> 
of course (at least on x86) !

> Also I have no idea if all x86 systems report the PC speaker in ACPI - a small
> survey of that would be probably a good idea. I guess just most of them reporting it would be 
> reasonable.
That's why I keep the platform driver :
the logic is try with ACPI in order to discover if there is a speaker. 
If we failed, let's try the platform driver.

Matthieu

PS : even system without ACPI should report the speaker with pnpbios.
