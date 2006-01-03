Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWACNw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWACNw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWACNw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:52:28 -0500
Received: from ns1.suse.de ([195.135.220.2]:51140 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751384AbWACNw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:52:27 -0500
From: Andi Kleen <ak@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 3 Jan 2006 14:52:09 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <p7364p1jvkx.fsf@verdi.suse.de> <200601031347.19328.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601031347.19328.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031452.10855.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 14:47, Alistair John Strachan wrote:

> It strikes me that it's a bit of a chicken and egg problem. Vendors are still 
> releasing applications on Linux that support only OSS, partly due to 
> ignorance, but mostly because ALSA's OSS compatibility layer allows them to 
> lazily ignore the ALSA API and target all cards, old and new.

As long as it works why is that a bad thing? OSS API works just fine
for most sound needs. If you want to do high end sound you can still
use ALSA.

> Additionally, we can't get rid of OSS compatibility until pretty much all 
> hardware has an ALSA driver, and (inferred from your comment) we can't get 
> rid of OSS drivers until nothing supports OSS, because the whole of the ALSA 
> stuff is a bit larger...

We can never get rid of it.
Linux doesn't break widely used application interfaces.

> Even if Adrian's not trying to make this point (he's just removing duplicate 
> drivers, and opting for the newer ones), we accepted ALSA into the kernel. 
> It's probably about time we let OSS die properly, for sanity purposes.

Avoiding bloat is more important.

-Andi
