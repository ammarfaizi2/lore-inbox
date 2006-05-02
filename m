Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWEBRuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWEBRuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWEBRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:50:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:52166 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964935AbWEBRuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:50:22 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Tue, 2 May 2006 19:50:17 +0200
User-Agent: KMail/1.9.1
Cc: matthieu castet <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301050.22984.ak@suse.de> <445798F6.3050102@free.fr>
In-Reply-To: <445798F6.3050102@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200605021950.17737.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 19:37, matthieu castet wrote:
> Hi,
> 
> Andi Kleen wrote:
> > On Saturday 29 April 2006 23:00, Matthieu CASTET wrote:
> > 
> >>Hi,
> >>
> >>Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a écrit :
> >>
> >>
> >>
> >>>Is there a better way to do this? ACPI?
> >>>
> >>
> >>Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PNP0800
> >>will be cleaner.
> > 
> > 
> > Please do a patch then.
> > 
> Is something like that is acceptable ?

Does it work? 

Also I have no idea if all x86 systems report the PC speaker in ACPI - a small
survey of that would be probably a good idea. I guess just most of them reporting it would be 
reasonable.

-Andi
