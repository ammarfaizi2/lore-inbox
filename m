Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVAZONS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVAZONS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVAZONR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:13:17 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:16850 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262307AbVAZOLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:11:00 -0500
In-Reply-To: <1106747097.6249.58.camel@gaston>
References: <1106747097.6249.58.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <115F6072-6FA4-11D9-9123-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Problem with cpu_rest() change
Date: Wed, 26 Jan 2005 08:10:44 -0600
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, will send a patch to back out the change that Linus already 
accepted.

- kumar

On Jan 26, 2005, at 7:44 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2005-01-25 at 23:45 -0600, Kumar Gala wrote:
>  > Will these changes cause us to back out the patch already made to
> > arch/ppc/kernel/idle.c for systems that did not support powersavings?
>
> Did it already make it upstream ? Ingo's fix should make our 
> workarounds
>  unnecessary indeed...
>
> Ben.

