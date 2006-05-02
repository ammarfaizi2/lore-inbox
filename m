Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWEBUfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWEBUfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWEBUfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:35:15 -0400
Received: from mail.suse.de ([195.135.220.2]:991 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751324AbWEBUfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:35:14 -0400
From: Andi Kleen <ak@suse.de>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Tue, 2 May 2006 22:35:09 +0200
User-Agent: KMail/1.9.1
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200605021950.17737.ak@suse.de> <4457C228.9050209@free.fr>
In-Reply-To: <4457C228.9050209@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022235.09381.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 22:33, matthieu castet wrote:
> Andi Kleen wrote:
> 
> > Does it work? 
> > 
> of course (at least on x86) !
> 
> > Also I have no idea if all x86 systems report the PC speaker in ACPI - a small
> > survey of that would be probably a good idea. I guess just most of them reporting it would be 
> > reasonable.
> That's why I keep the platform driver :
> the logic is try with ACPI in order to discover if there is a speaker. 
> If we failed, let's try the platform driver.

Ok - you mean just keeping the old code for that as fallback That makes sense.
 
> Matthieu
> 
> PS : even system without ACPI should report the speaker with pnpbios.

PNP BIOS doesn't work on 64bit.

-Andi
