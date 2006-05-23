Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWEWPGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWEWPGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWEWPGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:06:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63875 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750753AbWEWPGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:06:19 -0400
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Herman Elfrink <herman.elfrink@ti-wmc.nl>
In-Reply-To: <44732162.6080107@ti-wmc.nl>
References: <44731733.7000204@ti-wmc.nl>
	 <20060523073851.39c3b5fe@localhost.localdomain>
	 <44732162.6080107@ti-wmc.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 16:20:01 +0100
Message-Id: <1148397601.25255.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 16:51 +0200, Simon Oosthoek wrote:
> > Use of /proc for an API is no longer desirable. Please rewrite.
> > -
> 
> hmm, ok, I'm not sure this will happen anytime soon (being a rather low 
> priority thing, which is also the reason it's not submitted as patch to 
> the kernel and not signed off), but what is currently the desirable method?

sysfs will let you provide the same information in a much more
structured manner, and it will do most of the hard work for you as well.

